//
//  InterfaceController.swift
//  watchapp WatchKit Extension
//
//  Created by Steve Rogers on 3/11/2016.
//

import WatchKit
import WatchConnectivity
import Foundation


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    
    @IBOutlet var chatLabel: WKInterfaceLabel!
    @IBOutlet var phoneMsg: WKInterfaceLabel!
    var session = WCSession.defaultSession()
    var replyData: [String]?
    var autoReply = false
    
    
    // display the reply options
    @IBAction func messageReply() {
        presentControllerWithName("Replies", context: replyData)
    }
    
    // Set session up
    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Change chat label to show app is running ok
        chatLabel.setText("Phone Chat")
    }

    
    // Generate a random reply
    func generateRandomReply()->String {
        let diceRoll = Int(arc4random_uniform(UInt32(replyData!.count)))
        return replyData![diceRoll]
    }
    
    // Our delegate to receive the phone data
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]){
        
        
        // if we rx a replies list store it
        if let replyList = userInfo["replies"] {
            replyData = replyList  as? Array
        }
        
        // if we rx a message display it
        if let msgText = userInfo["message"] as? String {
            
            autoReply = userInfo["autoreply"] as! Bool

            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                self!.phoneMsg.setText(msgText)
                if self!.autoReply {
                    let replyMessage = self!.generateRandomReply()
                    session.transferUserInfo(["reply": replyMessage])
                }
            }
        }
        
        
    }
}
