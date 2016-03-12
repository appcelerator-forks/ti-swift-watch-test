//
//  RepliesInterfaceController.swift
//  watchapp
//
//  Created by Stephen Rogers on 11/03/2016.
//

import WatchKit
import Foundation
import WatchConnectivity

class RepliesInterfaceController: WKInterfaceController {

    @IBOutlet var repliesTable: WKInterfaceTable!
    var selectedIndex  = 0
    var replyArray: [String]?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // check if we have a valid replyModel and populate table
        if let replyModel = context as? [String] {
            
            NSLog("Model count: \(replyModel.count)")
            replyArray = replyModel
            repliesTable.setNumberOfRows(replyModel.count, withRowType: "replyRow")
            
            // create rows
            for index in 0..<repliesTable.numberOfRows {
                if let controller = repliesTable.rowControllerAtIndex(index) as? ReplyRowController {
                    controller.reply = replyModel[index] as String
                }
            }
            
        }
        
    }

    
    // when reply selected sent to phone and close controller
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        // get selected reply
        let reply = replyArray![rowIndex]
        selectedIndex = rowIndex
        
        // now send it back to the phone
        NSLog("Selected reply was \(reply)")
        _ = WCSession.defaultSession().transferUserInfo(["reply": reply])
        
        // close controller
        dismissController()
        
        
    }
}
