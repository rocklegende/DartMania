//
//  Dart.swift
//  DartMania
//
//  Created by Tim Hehmann on 15.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import GameplayKit

class Dart {
    var node: SKSpriteNode!
    
    init() {
        node = SKSpriteNode(imageNamed: "dartarrow.png")
        node.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.mass = 0.02 // 20 Gramm
    }
    
    
    
    func toss(angles: TossingAngles) {
        let directionVector = Helper.getDirectionVector(angles: angles)
        
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.applyImpulse(
            CGVector(
                dx: 0.1 * directionVector.dx,
                // dy: 0.1 * Helper.cap(value: directionVector.dy, max: maxThrowingAngleVector, min: minThrowingAngleVector)
                dy: 0.1 * directionVector.dy
            )
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            self.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.node.physicsBody?.affectedByGravity = false
        })
    }
    
    

}
