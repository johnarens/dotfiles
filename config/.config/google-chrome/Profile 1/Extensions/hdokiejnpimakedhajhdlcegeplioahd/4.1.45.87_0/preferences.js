Preferences=function(){var e=function(e,o){var t=LPPlatform.getPreference(e);if(o=void 0===o?r[e]:o,void 0===t)return o;if(typeof t!=typeof r[e])switch(typeof r[e]){case"boolean":return"true"===t||1===parseInt(t);case"number":return t=t.indexOf(".")===-1?parseInt(t):parseFloat(t),isNaN(t)?o:t;case"object":return JSON.parse(t)}return t},o=function(e){switch(typeof e){case"object":return JSON.stringify(e);case"boolean":return e?1:0;default:return e.toString()}},t={logoffWhenCloseBrowser:!0,logoffWhenCloseBrowserVal:!0,showvault:!0,hideContextMenus:!0,notificationsBottom:!0,usepopupfill:!0,openloginstart:!0,storeLostOTP:!0,enablenamedpipes:!0,enablenewlogin:!0,htmlindialog:!0,language:!0,Icon:!0,generateHkKeyCode:!0,generateHkMods:!0,recheckHkKeyCode:!0,recheckHkMods:!0,searchHkKeyCode:!0,searchHkMods:!0,nextHkKeyCode:!0,nextHkMods:!0,prevHkKeyCode:!0,prevHkMods:!0,homeHkKeyCode:!0,homeHkMods:!0,openpopoverHkKeyCode:!0,openpopoverHkMods:!0,rememberpassword:!0,dialogSizePrefs:!0},r={logoffWhenCloseBrowser:!1,logoffWhenCloseBrowserVal:0,idleLogoffEnabled:!1,idleLogoffVal:"",openpref:"tabs",htmlindialog:!1,highlightFields:!0,automaticallyFill:!0,showvault:!1,showAcctsInGroups:!0,hideContextMenus:!1,defaultffid:"0",donotoverwritefilledfields:!1,showNotifications:!0,showGenerateNotifications:!1,showFormFillNotifications:!1,showSaveSiteNotifications:!1,notificationsBottom:!1,showNotificationsAfterClick:!1,showFillNotificationBar:!1,showSaveNotificationBar:!0,showChangeNotificationBar:!0,usepopupfill:!0,showmatchingbadge:!0,autoautoVal:25,warninsecureforms:!1,infieldPopupEnabled:!1,dontfillautocompleteoff:!1,pollServerVal:15,clearClipboardSecsVal:60,recentUsedCount:10,searchNotes:!0,openloginstart:!1,storeLostOTP:!0,enablenamedpipes:!0,enablenewlogin:!1,clearfilledfieldsonlogoff:!1,toplevelmatchingsites:!1,language:"",Icon:1,generate_length:12,generate_upper:!0,generate_lower:!0,generate_digits:!0,generate_special:!1,generate_mindigits:1,generate_ambig:!1,generate_reqevery:!0,generate_pronounceable:!1,generate_advanced:!1,gridView:!0,compactView:!1,"seenVault4.0":!1,leftMenuMaximize:!0,disablepasswordmanagerasked:!0,rememberemail:!0,rememberpassword:!1,dialogSizePrefs:{},tempID:0,lastreprompttime:0,identity:"",alwayschooseprofilecc:!1};LPPlatform.adjustPreferenceDefaults(r),LPPlatform.isMac()?(r.generateHkKeyCode=0,r.generateHkMods="",r.recheckHkKeyCode=0,r.recheckHkMods="",r.searchHkKeyCode=0,r.searchHkMods="",r.nextHkKeyCode=33,r.nextHkMods="meta",r.prevHkKeyCode=34,r.prevHkMods="meta",r.homeHkKeyCode=0,r.homeHkMods="",r.openpopoverHkKeyCode=220,r.openpopoverHkMods="meta"):(r.generateHkKeyCode=71,r.generateHkMods="alt",r.recheckHkKeyCode=73,r.recheckHkMods="alt",r.searchHkKeyCode=87,r.searchHkMods="alt",r.nextHkKeyCode=33,r.nextHkMods="alt",r.prevHkKeyCode=34,r.prevHkMods="alt",r.homeHkKeyCode=72,r.homeHkMods="control alt",r.openpopoverHkKeyCode=220,r.openpopoverHkMods="alt");var a=function(e,o){LPPlatform.setUserPreference(e,o),t[e]&&LPPlatform.setGlobalPreference(e,o)};return{getDefault:function(e){switch(typeof e){case"object":var o={};for(var t in e)o[t]=r[t];return o;case"string":return r[e];default:return null}},get:function(o,t){switch(typeof o){case"object":var r={};for(var a in o)r[a]=e(a,t?t[a]:void 0);return r;case"string":return e(o,t);default:return null}},set:function(e,t){switch(typeof e){case"object":for(var r in e)a(r,o(e[r]));break;default:a(e,o(t))}LPPlatform.writePreferences()}}}();