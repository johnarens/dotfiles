// content script for login success page

if($('#gqUser').length > 0){
    setTimeout(function(){
        var user = $('#gqUser');
        var authKey = user.attr('authKey');
        var email = user.attr('email');
        chrome.runtime.sendMessage({action: "handleSuccessfulLogin", 'authKey' : authKey, 'email' : email }, function(response) { });


        var linkedText = email + " is now linked.";
        $('#gqLinkedMsg').text(linkedText);
        $('#gqConnecting').css('display', 'none');
        $('#gqLinked').css('display', 'block');

    }, 1500);
}

$("a, #gqCloseBtn").click(function(){
    chrome.runtime.sendMessage({action: "closeLoginWindow"}, function(response) { });
});
