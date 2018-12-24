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
    
    func getDirectionVector(angles: TossingAngles) -> CGVector {
        
        //TODO: calculate dx
        var dx = UIScreen.main.bounds.size.width * angles.xAngle / Settings.X_MAX_ANGLE
        let dy = UIScreen.main.bounds.size.height * angles.yAngle / Settings.Y_MAX_ANGLE
        
        return CGVector(dx: dx, dy: dy)
    }
    
    func toss(angles: TossingAngles) {
        //
        
        let directionVector = getDirectionVector(angles: angles)
        
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
