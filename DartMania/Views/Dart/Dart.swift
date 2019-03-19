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
    private var startPosition = CGPoint(x: 0, y: -200)
    private var isCurrentlyFlying = false
    private var sizeScaleFactor: CGFloat = 0.4
    private var dartHangTime: TimeInterval = 0.5
    
    init() {
        node = SKSpriteNode(imageNamed: "dartarrow.png")
        node.name = UINames.dartNode
        node.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.mass = 0.02 // 20 Gramm
        node.position = startPosition
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.zRotation = .pi / 6
    }
    
    func toss(angles: TossingAngles, hitDartboard: @escaping (Bool) -> ()) {
        let directionVector = Helper.getDirectionVector(angles: angles)
        isCurrentlyFlying = true
        node.physicsBody?.affectedByGravity = true
        
        runScaleAnimation()
        applyImpulse(vector: directionVector)
        DispatchQueue.main.asyncAfter(deadline: .now() + dartHangTime, execute: {
            self.performActionsAfterDartHitTheDartboard()
            hitDartboard(true)
        })
    }
    
    internal func applyImpulse(vector: CGVector) {
        node.physicsBody?.applyImpulse(
            CGVector(
                dx: 0.1 * vector.dx,
                dy: 0.1 * vector.dy
            )
        )
    }
    
    internal func runScaleAnimation() {
        let scaleAction = SKAction.scale(to: sizeScaleFactor, duration: dartHangTime)
        node.run(scaleAction)
    }
    internal func performActionsAfterDartHitTheDartboard() {
        self.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.node.physicsBody?.affectedByGravity = false
        self.isCurrentlyFlying = false
    }
    
    func isFlying() -> Bool {
        return isCurrentlyFlying
    }
    
    func resetToNormalSize() {
        node.setScale(1.0)
    }
    
    func resetToStartPosition() {
        node.position = startPosition
    }
    
    
}
