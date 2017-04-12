

// PRODUCTION
//*
var LOGIN_URL = "https://www.gqueues.com/oauth2/google/login?url=https://www.gqueues.com/gmailext?action=linkAccount";
var CREATE_TASK_URL = "https://www.gqueues.com/gmail";
var GET_ACCOUNT_DATA_URL = "https://www.gqueues.com/gmailGadgetContent";
//*/

// TESTING
/*
var LOGIN_URL = "http://localhost:8081/oauth2/google/login?url=http://localhost:8081/gmailext?action=linkAccount";
var CREATE_TASK_URL = "http://localhost:8081/gmail";
var GET_ACCOUNT_DATA_URL = "http://localhost:8081/gmailGadgetContent";
//*/

var _loginSourceTabId;
var _authKey;

var SYNC_INTERVAL = 86400000;  // 1 day in milliseconds


//--------------------------------------------------------------------------
// Google Analytics
//--------------------------------------------------------------------------

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-55484434-2', 'auto');
// this line added so it works in extension
// per this SO post: http://stackoverflow.com/questions/16135000
ga('set', 'checkProtocolTask', function(){});
ga('send', 'pageview');


//--------------------------------------------------------------------------
// Load authKey
//--------------------------------------------------------------------------

//console.log("Background JS Loading...");

chrome.storage.sync.get("GQ_STORAGE_USER_KEY", function(users) {

    console.log("background.users", users);

    var userObj = users['GQ_STORAGE_USER_KEY'];

    if(userObj === undefined || userObj === null){
        return;
    }

    //console.log("authKey from storage", userObj['authKey']);
    //console.log("email from storage", userObj['email']);
    _authKey = userObj['authKey'];

    // sync from web if it's been awhile since last syncing
    chrome.storage.local.get("GQ_STORAGE_USER_DATA_LAST_SYNC", function(data) {

        //console.log("data", data);

        var currTime = new Date().getTime();
        var lastSyncTime = 0;
        var lastSyncTimeObj = data["GQ_STORAGE_USER_DATA_LAST_SYNC"];
        if(lastSyncTimeObj){
            lastSyncTime = lastSyncTimeObj.lastSyncStamp;
        }

        var milliSinceLastSync = currTime - lastSyncTime;

        //console.log("currTime", currTime);
        //console.log("lastSyncTime", lastSyncTime);
        //console.log("milliSinceLastSync", milliSinceLastSync);

        if(!lastSyncTime || (milliSinceLastSync > SYNC_INTERVAL)){
            //console.log("SYNCING FROM WEB");
            _getAccountData();
        } else {
            //console.log("NOT SYNCING FROM WEB");
        }


    });

});  

//--------------------------------------------------------------------------
// Listener for storage changes
//--------------------------------------------------------------------------
chrome.storage.onChanged.addListener(function(changes, namespace) {
    for (key in changes) {

        var storageChange = changes[key];
        /*
        console.log('Storage key "%s" in namespace "%s" changed. ' + 'Old value was "%s", new value is "%s".',
                  key,
                  namespace,
                  storageChange.oldValue,
                  storageChange.newValue);
        */

        if(key === "GQ_STORAGE_USER_KEY"){
            var userObj = storageChange.newValue;
            if(userObj !== undefined){
                _authKey = userObj.authKey;
                //console.log("setting authKey in background.js to ", _authKey);
            }
        }
    }
});

//--------------------------------------------------------------------------
// Listener for location changes
//--------------------------------------------------------------------------

chrome.tabs.onUpdated.addListener( function (tabId, changeInfo, tab) {
  if (changeInfo.status == 'complete' && tab.active) {

    // notify content script of active tab
    chrome.tabs.sendMessage(tabId, {action: "locationUpdated"} );

  }
})


//--------------------------------------------------------------------------
// Message handlers
//--------------------------------------------------------------------------

chrome.runtime.onMessage.addListener(

    function(request, sender, sendResponse) {
        console.log(sender.tab ? "from a content script:" + sender.tab.url : "from the extension");

        if (request.action == "createTask"){
            _createTask(request, sender, sendResponse);
            return;
        }

        if (request.action == "showLoginWindow"){
            _showLoginWindow(request, sender, sendResponse);
            return;
        }

        if (request.action == "handleSuccessfulLogin"){
            _handleSuccessfulLogin(request, sender, sendResponse);
            return;
        }

        if (request.action == "closeLoginWindow"){
            _closeLoginWindow(request, sender, sendResponse);
            return;
        }

        if (request.action == "getAccountData"){
            _getAccountData(request, sender, sendResponse);
            return;
        }

        if (request.action == "recordShowEvent"){
            _recordShowEvent(request, sender, sendResponse);
            return;
        }

    }

);


//--------------------------------------------------------------------------

var _showLoginWindow = function(request, sender, sendResponse){

    _loginSourceTabId = sender.tab.id;

    var windowWidth = 600;
    var windowHeight = 600;
    var windowLeft = Math.round((screen.width/2)-(windowWidth/2));
    var windowTop = Math.round((screen.height/2)-(windowHeight/2));


    chrome.windows.create({
                            'url' : LOGIN_URL,
                            'left' : windowLeft,
                            'top' : windowTop,
                            'width' : windowWidth,
                            'height' : windowHeight,
                            'type' : "popup",
                            'focused' : true
                           },
                            function(newWindow){
                            });


};

//--------------------------------------------------------------------------

var _closeLoginWindow = function(request, sender, sendResponse){

    chrome.windows.remove(sender.tab.windowId);

}

//--------------------------------------------------------------------------

var _handleSuccessfulLogin = function(request, sender, sendResponse){

    console.log("sender of successlogin ", sender);

    _closeLoginWindow(request, sender, sendResponse);

    var userObj = { 'authKey' : request.authKey, 'email' : request.email };

    chrome.storage.sync.set({   'GQ_STORAGE_USER_KEY': userObj,
                                "GQ_STORAGE_EMAIL_LINK_KEY" : true,
                                "GQ_STORAGE_EMAIL_ORIGINAL_KEY" : false, 
                                "GQ_STORAGE_KEYBOARD_SHORTCUT_KEY" : true,
                                }, function() {
        console.log('userObj saved', request.authKey);
        console.log('userObj saved email', request.email);
        chrome.tabs.sendMessage(_loginSourceTabId, {action: "setKeyboardShortcutSetting"} );
        chrome.tabs.sendMessage(_loginSourceTabId, {action: "showAddTaskPopup"} );

    });

}

//--------------------------------------------------------------------------

var _getAccountData = function(request, sender, sendResponse){

    console.log("getting account data from background.js");

    if(_authKey === undefined || _authKey === null){
        // send error
        if(sendResponse){
            sendResponse({error: "noAuthKey"});
        }
        return;
    }

    $.ajax({
        type: "POST",
        cache: false,
        url: GET_ACCOUNT_DATA_URL,
        data: {'authKey': _authKey},
        dataType: "json",
        success: function(data){

            if(sender){
                chrome.tabs.sendMessage(sender.tab.id, {action: "loadData", userData : data} );
            }

            chrome.storage.local.set({'GQ_STORAGE_USER_DATA_KEY': data}, function() {
                console.log('GQ_STORAGE_USER_DATA_KEY saved', data);

            });

            // save last syncTime
            var syncTime = new Date().getTime();
            var syncData = { 'lastSyncStamp' : syncTime };
            chrome.storage.local.set({'GQ_STORAGE_USER_DATA_LAST_SYNC': syncData }, function() {
                console.log('GQ_STORAGE_USER_DATA_LAST_SYNC saved', syncData);
            });

        },
        error: function(request, textStatus, errorThrown){

            if(request.status === 403){
                _authKey = null;
                chrome.storage.sync.clear(function(){ });
                chrome.tabs.sendMessage(sender.tab.id, {action: "createUnauthorized" } );

            } else {
                chrome.tabs.sendMessage(sender.tab.id, {action: "showError", errorMsg : "There was an error refreshing account data." } );

            }

        }

    });

};


//--------------------------------------------------------------------------

var _createTask = function(request, sender, sendResponse){

    if(_authKey === null){
        // send error
    }


    request.postData.authKey = _authKey;

    var gaAction = "withoutEmailAttached";
    if(request.postData.addAttachments){
        gaAction = "withEmailAttached";
    }

    $.ajax({
        type: "POST",
        cache: false,
        url: CREATE_TASK_URL,
        data: request.postData,
        success: function(data){
            chrome.tabs.sendMessage(sender.tab.id, {action: "createSuccess", "data" : data } );

            console.log("recording create ", gaAction);
            ga('send', 'event', 'createTask', gaAction, 'success');
        },
        error: function(request, textStatus, errorThrown){

            if(request.status === 403){
                _authKey = null;
                chrome.storage.sync.clear(function(){ });
                chrome.tabs.sendMessage(sender.tab.id, {action: "createUnauthorized" } );
                return;
            }

            console.log("recording create ", gaAction);
            ga('send', 'event', 'createTask', gaAction, 'failure');

            chrome.tabs.sendMessage(sender.tab.id, {action: "showError", errorMsg : "There was an error creating the task." } );

        }
    });


};

//--------------------------------------------------------------------------

var _recordShowEvent = function(request, sender, sendResponse){

    console.log("recording show event");
    ga('send', 'event', 'showCreateWindow' );

};
