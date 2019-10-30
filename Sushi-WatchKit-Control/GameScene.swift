//
//  GameScene.swift
//  himu
//
//  Created by Himanshu Mehta on 2019-10-29.
//  Copyright © 2019 Himanshu Mehta. All rights reserved.
//

import SpriteKit
import GameplayKit
import WatchConnectivity

class GameScene: SKScene, WCSessionDelegate {
    
       
        func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            
        }
        
        func sessionDidBecomeInactive(_ session: WCSession) {
            
        }
        
        func sessionDidDeactivate(_ session: WCSession) {
            
        }
        
        
        func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            // Output message to terminal
            print("WATCH: I received a message: \(message)")
            
            // Get the "name" key out of the dictionary
            // and show it in the label
            let name = message["name"] as! String
            print("\(name)")
    //        let color = message["color"] as! String
    //        msgFromWatch.text = name
    //        msgFromWatcholor.text = color
        }
    
    let cat = SKSpriteNode(imageNamed: "character1")
    let sushiBase = SKSpriteNode(imageNamed:"roll")

    // Make a tower
    var sushiTower:[SushiPiece] = []
    let SUSHI_PIECE_GAP:CGFloat = 80
    var catPosition = "left"
    
    // Show life and score labels
    let lifeLabel = SKLabelNode(text:"Lives: ")
    let scoreLabel = SKLabelNode(text:"Score: ")
    
    var lives = 5
    var score = 0
    
    
    func spawnSushi() {
        
        // -----------------------
        // MARK: PART 1: ADD SUSHI TO GAME
        // -----------------------
        
        // 1. Make a sushi
        let sushi = SushiPiece(imageNamed:"roll")
        
        // 2. Position sushi 10px above the previous one
        if (self.sushiTower.count == 0) {
            // Sushi tower is empty, so position the piece above the base piece
            sushi.position.y = sushiBase.position.y
                + SUSHI_PIECE_GAP
            sushi.position.x = self.size.width*0.5
        }
        else {
            // OPTION 1 syntax: let previousSushi = sushiTower.last
            // OPTION 2 syntax:
            let previousSushi = sushiTower[self.sushiTower.count - 1]
            sushi.position.y = previousSushi.position.y + SUSHI_PIECE_GAP
            sushi.position.x = self.size.width*0.5
        }
        
        // 3. Add sushi to screen
        addChild(sushi)
        
        // 4. Add sushi to array
        self.sushiTower.append(sushi)
    }
    
    override func didMove(to view: SKView) {
                          if(WCSession.isSupported() == true){
        //                      checkConnection.text = "WC is supported"
                              
                  //            create a communication session with the watch?
                                  let session = WCSession.default
                                       session.delegate = self
                                       session.activate()
                                   }
                                   else {
        //                               checkConnection.text = "WC NOT supported!"
                                   }

        
        
        
        
        // add background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        // add cat
        cat.position = CGPoint(x:self.size.width*0.25, y:100)
        addChild(cat)
        
        // add base sushi pieces
        sushiBase.position = CGPoint(x:self.size.width*0.5, y: 100)
        addChild(sushiBase)
        
        // build the tower
        self.buildTower()
        
        // Game labels
        self.scoreLabel.position.x = 60
        self.scoreLabel.position.y = size.height - 50
        self.scoreLabel.fontName = "Avenir"
        self.scoreLabel.fontSize = 30
        addChild(scoreLabel)
        
        // Life label
        self.lifeLabel.position.x = 60
        self.lifeLabel.position.y = size.height - 80
        self.lifeLabel.fontName = "Avenir"
        self.lifeLabel.fontSize = 30
        addChild(lifeLabel)
    }
    
    func buildTower() {
        for _ in 0...10 {
            self.spawnSushi()
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        // This is the shortcut way of saying:
        //      let mousePosition = touches.first?.location
        //      if (mousePosition == nil) { return }
        guard let mousePosition = touches.first?.location(in: self) else {
            return
        }

        print(mousePosition)
        
        // ------------------------------------
        // MARK: UPDATE THE SUSHI TOWER GRAPHICS
        //  When person taps mouse,
        //  remove a piece from the tower & redraw the tower
        // -------------------------------------
        let pieceToRemove = self.sushiTower.first
        if (pieceToRemove != nil) {
            // SUSHI: hide it from the screen & remove from game logic
            pieceToRemove!.removeFromParent()
            self.sushiTower.remove(at: 0)
            
            // SUSHI: loop through the remaining pieces and redraw the Tower
            for piece in sushiTower {
                piece.position.y = piece.position.y - SUSHI_PIECE_GAP
            }
            
            // To make the tower inifnite, then ADD a new piece
            self.spawnSushi()
        }
        
        // ------------------------------------
        // MARK: SWAP THE LEFT & RIGHT POSITION OF THE CAT
        //  If person taps left side, then move cat left
        //  If person taps right side, move cat right
        // -------------------------------------
        
        // 1. detect where person clicked
        let middleOfScreen  = self.size.width / 2
        if (mousePosition.x < middleOfScreen) {
            print("TAP LEFT")
            // 2. person clicked left, so move cat left
            cat.position = CGPoint(x:self.size.width*0.25, y:100)
            
            // change the cat's direction
            let facingRight = SKAction.scaleX(to: 1, duration: 0)
            self.cat.run(facingRight)
            
            // save cat's position
            self.catPosition = "left"
            
        }
        else {
            print("TAP RIGHT")
            // 2. person clicked right, so move cat right
            cat.position = CGPoint(x:self.size.width*0.85, y:100)
            
            // change the cat's direction
            let facingLeft = SKAction.scaleX(to: -1, duration: 0)
            self.cat.run(facingLeft)
            
            // save cat's position
            self.catPosition = "right"
        }

        // ------------------------------------
        // MARK: ANIMATION OF PUNCHING CAT
        // -------------------------------------
        
        // show animation of cat punching tower
        let image1 = SKTexture(imageNamed: "character1")
        let image2 = SKTexture(imageNamed: "character2")
        let image3 = SKTexture(imageNamed: "character3")
        
        let punchTextures = [image1, image2, image3, image1]
        
        let punchAnimation = SKAction.animate(
            with: punchTextures,
            timePerFrame: 0.1)
        
        self.cat.run(punchAnimation)
        
        
        // ------------------------------------
        // MARK: WIN AND LOSE CONDITIONS
        // -------------------------------------
        
        if (self.sushiTower.count > 0) {
            // 1. if CAT and STICK are on same side - OKAY, keep going
            // 2. if CAT and STICK are on opposite sides -- YOU LOSE
            let firstSushi:SushiPiece = self.sushiTower[0]
            let chopstickPosition = firstSushi.stickPosition
            
            if (catPosition == chopstickPosition) {
                // cat = left && chopstick == left
                // cat == right && chopstick == right
                print("Cat Position = \(catPosition)")
                print("Stick Position = \(chopstickPosition)")
                print("Conclusion = LOSE")
                print("------")
                
                self.lives = self.lives - 1
                self.lifeLabel.text = "Lives: \(self.lives)"
            }
            else if (catPosition != chopstickPosition) {
                // cat == left && chopstick = right
                // cat == right && chopstick = left
                print("Cat Position = \(catPosition)")
                print("Stick Position = \(chopstickPosition)")
                print("Conclusion = WIN")
                print("------")
                
                self.score = self.score + 10
                self.scoreLabel.text = "Score: \(self.score)"
            }
        }
        
        else {
            print("Sushi tower is empty!")
        }
        
    }
 
}
