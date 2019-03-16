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
    private var startPosition = CGPoint(x: 0, y: 0)
    private var isCurrentlyFlying = false
    
    init() {
        node = SKSpriteNode(imageNamed: "dartarrow.png")
        node.name = UINames.dartNode
        node.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.mass = 0.02 // 20 Gramm
        node.position = startPosition
    }
    
    func toss(angles: TossingAngles, completion: @escaping (Bool) -> ()) {
        let directionVector = Helper.getDirectionVector(angles: angles)
        isCurrentlyFlying = true
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.applyImpulse(
            CGVector(
                dx: 0.1 * directionVector.dx,
                dy: 0.1 * directionVector.dy
            )
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            self.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.node.physicsBody?.affectedByGravity = false
            self.isCurrentlyFlying = false
            completion(true)
        })
    }
    
    func isFlying() -> Bool {
        return isCurrentlyFlying
    }
    
    func resetToStartPosition() {
        node.position = startPosition
    }
    
    
}
