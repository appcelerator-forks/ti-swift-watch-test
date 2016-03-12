/**
 * index controller
 * Sample app with watchOS2 connectivity.
 * 
 */

 

(function(){

	// Is this the right version of the Ti SDK?
	if(Alloy.Globals.TI_VERSION < 5){
		alert("TiSDK must be 5 or later")
		$.sdkStatus.text = "Incorrect TiSDK for iWatch connectivity"
		$.chat.enabled = false;
	} else {
		if (Ti.WatchSession.isSupported) {
			Ti.WatchSession.activateSession();
			$.watchStatus.text = "Watch Session Supported and Activated";
			sendRepliesToWatch();
			Ti.WatchSession.addEventListener('receiveuserinfo',function(e){
				Ti.API.info(e.userInfo.reply);
				$.messageList.add(Ti.UI.createLabel({height: Ti.UI.SIZE, width: Ti.UI.FILL, text: " >" + e.userInfo.reply, color: "#FF0000"}));
			});


		} else {
			$.watchStatus.text = "Watch Session not Supported";
			$.chat.enabled = false;
		}		
	}

	$.index.open();

})();


/**
 * Send the canned replies to the watch
 */
function sendRepliesToWatch(){

		Ti.WatchSession.transferUserInfo({"replies":[
			"OK",
			"See you later",
			"LOL",
			"No",
			"Phone you",
			"Your joking",
			"Don't be daft",
			"Brill",
			"Fab"
		]});
}


/**
 * Process and send the message to the watch
 */
function processMessage(e){

	// get message and record it
	var message = $.chat.getValue();
	$.messageList.add(Ti.UI.createLabel({height: Ti.UI.SIZE, width: Ti.UI.FILL, text: message, color: "#0000FF"}));

	// send message to watch
	Ti.WatchSession.transferUserInfo({"message": message, "autoreply": $.autoReply.value});

	// now clear typed message
	$.chat.setValue("");
}

