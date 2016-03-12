//
//  ReplyRowController.swift
//  watchapp
//
//  Created by Stephen Rogers on 11/03/2016.
//

import WatchKit

class ReplyRowController: NSObject {

    @IBOutlet var replyLabel: WKInterfaceLabel!
    

    var reply: String? {
        didSet {
            if let reply = reply {
                replyLabel.setText(reply)
            }
        }
    }

    
    
}
