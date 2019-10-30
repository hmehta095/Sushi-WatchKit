//
//  InterfaceController.swift
//  Sushi-WatchKit-Control WatchKit Extension
//
//  Created by Himanshu Mehta on 2019-10-25.
//  Copyright © 2019 Himanshu Mehta. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController,WCSessionDelegate {
func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
   
}
// Function to receive DICTIONARY from the watch

    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Output message to terminal
        print("WATCH: I received a message: \(message)")
        
        // Get the "name" key out of the dictionary
        // and show it in the label
        let name = message["name"] as! String
        print(name)

        timeLabel.setText(name)

    }



    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("---WATCH APP LOADED")
        
        if (WCSession.isSupported() == true) {
//            msgFromPhoneLabel.setText("WC is supported!")
            
            // create a communication session with the phone
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else {
//            msgFromPhoneLabel.setText("WC NOT supported!")
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func leftButtonPressed() {
        
        print("Sending message to phone")
                                  // ------ SEND MESSAGE TO WATCH CODE GOES HERE

                               if(WCSession.default.isReachable == true){
                       //            Here is the message you want to send to the watch
                                   let message = ["name":"left"]
                                   WCSession.default.sendMessage(message, replyHandler: nil)
               //                    messageCounter = messageCounter+1
//                                 sendMessageOutputLabel.setText("Message Sent")
                                   }
                                   else {
               //                        messageCounter = messageCounter + 1
//                                       sendMessageOutputLabel.setText("Cannot reach watch! ")
                                   }
    }
    
    @IBAction func rightButtonPressed() {
        print("Sending message to phone")
                                  // ------ SEND MESSAGE TO WATCH CODE GOES HERE

                               if(WCSession.default.isReachable == true){
                       //            Here is the message you want to send to the watch
                                   let message = ["name":"right"]
                                   WCSession.default.sendMessage(message, replyHandler: nil)
               //                    messageCounter = messageCounter+1
//                                 sendMessageOutputLabel.setText("Message Sent")
                                   }
                                   else {
               //                        messageCounter = messageCounter + 1
//                                       sendMessageOutputLabel.setText("Cannot reach watch! ")
                                   }
    }
}
