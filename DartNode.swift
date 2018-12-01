//
//  DartNode.swift
//  DartMania
//
//  Created by Tim Hehmann on 16.09.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import SpriteKit
import GameplayKit

class DartNode: SKShapeNode {
    
    private var swipeStartPoint: CGPoint?
    private var swipeEndPoint: CGPoint?
    
    private var velocity: CGFloat = 3 //meters per second
    private var maxThrowingAngle: CGFloat = 1.047 //400 = 60 Grad
    private var minThrowingAngle: CGFloat = 0.175 //50 = 10 Grad
    private var maxThrowingAngleVector: CGFloat = 400
    private var minThrowingAngleVector: CGFloat = 50
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 0.02 // 20 Gramm
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getFlyingTime (distanceToDartBoard: CGFloat, velocity: CGFloat, angle: CGFloat) -> Double {
        let time = (Double) (distanceToDartBoard / (velocity * cos(angle)))
        print("Flying Time in seconds: \(time)")
        return time
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print(touches.first?.location(in: self))
        swipeStartPoint = touches.first?.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print(touches.first?.location(in: self))
        swipeEndPoint = touches.first?.location(in: self)
        //TODO: find library for this subtraction
        let directionVector = CGVector(
            dx: (swipeEndPoint?.x)! - (swipeStartPoint?.x)!,
            dy: (swipeEndPoint?.y)! - (swipeStartPoint?.y)!
        )
        throwDart(directionVector: directionVector, distanceToDartBoard: 2.37, velocity: velocity)
        
        
    }
    
    func getYAngle(directionVector: CGVector) -> CGFloat {
        let temp = Helper.cap(value: directionVector.dy, max: maxThrowingAngleVector, min: minThrowingAngleVector)
        //calculate angle
        let percentage = (temp - minThrowingAngleVector) / (maxThrowingAngleVector - minThrowingAngleVector)
        let resultAngle = minThrowingAngle + (percentage * (maxThrowingAngle - minThrowingAngle))
        
        print("Throwing Angle (rad): \(resultAngle)")
        print("Throwing Angle (deg): \(resultAngle * 180 / CGFloat.pi)")
        
        return resultAngle
    }
    
    func throwDart(directionVector: CGVector, distanceToDartBoard: CGFloat, velocity: CGFloat) {
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.applyImpulse(
            CGVector(
                dx: 0.1 * directionVector.dx,
                dy: 0.1 * Helper.cap(value: directionVector.dy, max: maxThrowingAngleVector, min: minThrowingAngleVector)
            )
        )
        print("")
        print("Direction Vector: \(directionVector)")
        DispatchQueue.main.asyncAfter(
                deadline: .now() + getFlyingTime(
                                        distanceToDartBoard: distanceToDartBoard,
                                        velocity: velocity,
                                        angle: getYAngle(directionVector: directionVector))
                                    )
        {
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.physicsBody?.affectedByGravity = false
        }
    }
    
}
