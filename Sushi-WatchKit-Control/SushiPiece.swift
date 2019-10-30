//
//  SushiPiece.swift
//  SushiTower
//
//  Created by Parrot on 2019-02-17.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import SpriteKit

// A custom SpriteNode class.
// Used to represent a piece of sushi in the tower.
class SushiPiece: SKSpriteNode {
    
    // MARK: Variables
    // --------------------------------
    var stickGraphic:SKSpriteNode!
    var stickPosition:String = ""

    // MARK: Constructor - required nonsense
    // --------------------------------
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        // @TODO Fix this so its alawys the same picture
        //self.texture = SKTexture(imageNamed: "roll");
        
        // 1. setup our chopstick images
        self.stickGraphic = SKSpriteNode(imageNamed: "chopstick")
        // 2. set the stick position
        // -------------------------
        // randomly generate the position of the stick
        let pos = Int.random(in: 0...2)
        if (pos == 0) {
            self.stickPosition = ""
            
            // no need to show the stick on the screen
        }
        else if (pos == 1) {
            self.stickPosition = "right"
            
            // right
            self.stickGraphic.position.x = self.position.x + 100
            self.stickGraphic.position.y = self.position.y - 10
            
            // flip the image
            let facingRight = SKAction.scaleX(to: -1, duration: 0)
            self.stickGraphic.run(facingRight)
            
            // -------------------------
            // 3. show the stick on the screen
            addChild(self.stickGraphic)
        }
        else if (pos == 2) {
            self.stickPosition = "left"
            
            // left
            self.stickGraphic.position.x = self.position.x - 100
            self.stickGraphic.position.y = self.position.y - 10
            
            // -------------------------
            // 3. show the stick on the screen
            addChild(self.stickGraphic)
        }
        
        
       
    }
    
    // Required nonsense
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark:  Functions
    // --------------------------------
}
