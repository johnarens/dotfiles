// content script for login success page

if($('#gqUser').length > 0){
    setTimeout(function(){
        var user = $('#gqUser');
        var authKey = user.attr('authKey');
        var email = user.attr('email');
        chrome.runtime.sendMessage({action: "handleSuccessfulLogin", 'authKey' : authKey, 'email' : email }, function(response) { });
    }, 1500);
}

$("a").click(function(){
    chrome.runtime.sendMessage({action: "closeLoginWindow"}, function(response) { });
});
