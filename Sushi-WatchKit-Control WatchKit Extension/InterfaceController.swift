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

    @IBOutlet weak var powerButton: WKInterfaceButton!
    @IBOutlet weak var powerUp: WKInterfaceLabel!
    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Output message to terminal
        print("WATCH: I received a message: \(message)")
        
        // Get the "name" key out of the dictionary
        // and show it in the label
        let name = message["name"] as! String
        let power = message["power"] as! String
        print(power)
        powerUp.setText(power)
        timeLabel.setText(name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.powerUp.setText("")
        }
        
        if(power == "Click to Power-UP"){
           self.powerButton.setHidden(false)
           self.powerButton.setTitle("POWER UP")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.powerButton.setHidden(true)
            }
       }

    }

    @IBAction func PowerUpButtonPressed() {
        print("Power Up Pressed")
        if(WCSession.default.isReachable == true){
        //            Here is the message you want to send to the watch
            let message = ["name":"","powerTime":"powerAdd"] as [String : Any]
                   WCSession.default.sendMessage(message, replyHandler: nil)
                   }
    }
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("---WATCH APP LOADED")
        self.powerButton.setHidden(true)
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
           let message = ["name":"left","time":""] as [String : Any]
           WCSession.default.sendMessage(message, replyHandler: nil)
           }
           else {
           }
    }
    
    @IBAction func rightButtonPressed() {
        print("Sending message to phone")
          // ------ SEND MESSAGE TO WATCH CODE GOES HERE

       if(WCSession.default.isReachable == true){
//            Here is the message you want to send to the watch
           let message = ["name":"right","time":""] as [String : Any]
           WCSession.default.sendMessage(message, replyHandler: nil)
           }
           else {

           }
    }
}
