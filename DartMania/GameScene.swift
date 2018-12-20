//
//  GameScene.swift
//  DartMania
//
//  Created by Tim Hehmann on 16.09.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import SpriteKit
import GameplayKit

struct TossingAngles {
    var xAngle: CGFloat
    var yAngle: CGFloat
}

class GameScene: SKScene {
    // private var dart: DartNode?
    private var dart: Dart!
    private var dartboard: Dartboard!
    
    private var swipeStartPoint: CGPoint?
    private var swipeEndPoint: CGPoint?
    
    override func didMove(to view: SKView) {
        
        self.isUserInteractionEnabled = true
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -20.0)
        
        self.dartboard = Dartboard()
        self.view?.addSubview(dartboard.view!)
        
        self.dart = Dart()
        self.addChild(dart.node!)
        
//        self.dart = DartNode(circleOfRadius: 100)
//        self.addChild(self.dart!)
        
//        self.dartboard = Dartboard()
//        self.addChild(self.dartboard!)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            if (dart.node.contains(touchPoint)) {
                swipeStartPoint = touchPoint
                print(swipeStartPoint)
            } else {
                print("touch the ball!")
            }
        } else {
            print("error getting first touch position of dragevent")
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (swipeStartPoint != nil) {
            if let touchPoint = touches.first?.location(in: self) {
                swipeEndPoint = touchPoint
                let directionVector = CGVector(
                    dx: (swipeEndPoint?.x)! - (swipeStartPoint?.x)!,
                    dy: (swipeEndPoint?.y)! - (swipeStartPoint?.y)!
                )
                
                let angles = getAngles(directionVector: directionVector)
                
                dart.toss(angles: angles)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    print(self.dart.node.position)
                    let points = self.dartboard.getHitPoints(point: self.convertPoint(toView: self.dart.node.position))
                    print(points)
                })
                
                
                
                swipeStartPoint = nil
                swipeEndPoint = nil
                
            } else {
                print("error getting touch position of releasing touch of the dragevent")
            }
        }
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func getAngles(directionVector: CGVector) -> TossingAngles {
        
        let yMaxPixelDirection = UIScreen.main.bounds.size.height
        print(yMaxPixelDirection)
        let yAngle = Settings.Y_MAX_ANGLE * (directionVector.dy / yMaxPixelDirection)
        print(yAngle)
        let xAngle = CGFloat(0.0)
        
        return TossingAngles(xAngle: xAngle, yAngle: yAngle)
        
    }
}
