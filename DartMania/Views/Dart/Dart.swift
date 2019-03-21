//
//  Dart.swift
//  DartMania
//
//  Created by Tim Hehmann on 15.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import GameplayKit

class Dart: SKSpriteNode {
    private var startPosition = CGPoint(x: 0, y: -200)
    private var isCurrentlyFlying = false
    private var sizeScaleFactor: CGFloat = 0.4
    private var dartHangTime: TimeInterval = 0.5
    private var timeTillNextDartCanBeThrown: TimeInterval = 0.5
    private var swipeStartPoint: CGPoint?
    private var swipeEndPoint: CGPoint?
    var isOnDartboard: Bool = false
    weak var dartThrowDelegate: DartThrowDelegate?
    
    init() {
        let texture = SKTexture(imageNamed: "dartarrow.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name = UINames.dartNode
        setupPhysicsBody()
        
        isUserInteractionEnabled = true
        position = startPosition
        anchorPoint = CGPoint(x: 0.5, y: 0)
        
    }
    
    func setupPhysicsBody() {
        physicsBody = SKPhysicsBody(circleOfRadius: 100)
        physicsBody?.affectedByGravity = false
        physicsBody?.collisionBitMask = 0
        physicsBody?.mass = 0.02 // 20 Gramm
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            handleTouchBegin(touchPoint)
        } else {
            print("error getting first touch position of dragevent")
        }
    }
    
    internal func handleTouchBegin(_ touchPoint: CGPoint) {
        swipeStartPoint = touchPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            handleTouchEnd(touchPoint)
        } else {
            print("error getting touch position of releasing touch of the dragevent")
        }
    }
    
    internal func handleTouchEnd(_ touchPoint: CGPoint) {
        if (swipeStartPoint != nil) {
            swipeEndPoint = touchPoint
            performDartThrow()
        }
    }
    
    func performDartThrow() {
        let directionVector = Helper.getDirectionVectorFromSwipePoints(startPoint: swipeStartPoint!, endPoint: swipeEndPoint!)
        let angles = Helper.getAngles(directionVector: directionVector)
        
        isUserInteractionEnabled = false //once the dart is thrown all interaction with it is disabled
        toss(angles: angles) { (hitDartboard) in
            if (hitDartboard) {
                self.performActionsAfterDartHitTheDartboard()
            }
        }
    }
    
    func handleCompletedThrow() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func toss(angles: TossingAngles, hitDartboard: @escaping (Bool) -> ()) {
        let directionVector = Helper.getDirectionVector(angles: angles)
        isCurrentlyFlying = true
        physicsBody?.affectedByGravity = true
        
        runScaleAnimation()
        applyImpulse(vector: directionVector)
        DispatchQueue.main.asyncAfter(deadline: .now() + dartHangTime, execute: {
            hitDartboard(true)
        })
    }
    
    internal func applyImpulse(vector: CGVector) {
        physicsBody?.applyImpulse(
            CGVector(
                dx: 0.1 * vector.dx,
                dy: 0.12 * vector.dy
            )
        )
    }
    
    internal func runScaleAnimation() {
        let scaleAction = SKAction.scale(to: sizeScaleFactor, duration: dartHangTime)
        run(scaleAction)
    }
    internal func performActionsAfterDartHitTheDartboard() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.affectedByGravity = false
        self.isCurrentlyFlying = false
        isOnDartboard = true
        dartThrowDelegate?.dartDidTouchDartboard(dart: self)
        
    }
    
    func isFlying() -> Bool {
        return isCurrentlyFlying
    }
}
