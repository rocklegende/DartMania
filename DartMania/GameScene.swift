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
    private var label: SKLabelNode!
    
    private var swipeStartPoint: CGPoint?
    private var swipeEndPoint: CGPoint?
    
    override func didMove(to view: SKView) {
        
        self.isUserInteractionEnabled = true
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -20.0)
        
        self.dartboard = Dartboard(gameScene: self)
        // maybe better: for every dartboardelement in dartboard.elements: addChild(element)
        
        self.dart = Dart()
        self.addChild(dart.node!)
        
        self.label = SKLabelNode(text: "Points: ")
        self.label.fontSize = 60
        self.label.position = CGPoint(x: 0, y: -400)
        self.addChild(self.label)
        
        
        
//        self.dart = DartNode(circleOfRadius: 100)
//        self.addChild(self.dart!)
        
//        self.dartboard = Dartboard()
//        self.addChild(self.dartboard!)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            print(dartboard.getHitPoints(point: touchPoint))
            print(touchPoint)
            if (dart.node.contains(touchPoint)) {
                swipeStartPoint = touchPoint
                //print(swipeStartPoint)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                    print(self.dart.node.frame)
                    print(self.dart.node.frame.minX)
                    print(self.dart.node.frame.minY)
                    let dartTouchPoint = CGPoint(x: self.dart.node.frame.minX, y: self.dart.node.frame.minY)
                    self.label.text = "Points: \(self.dartboard.getHitPoints(point: dartTouchPoint))"
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.dart.node.position = CGPoint(x: 0, y: -200)
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
        
        var xMaxPixelDirection = UIScreen.main.bounds.size.width
        print(xMaxPixelDirection)
        var xAngle = CGFloat(0.0)
        if (directionVector.dx < 0) {
            xMaxPixelDirection = -xMaxPixelDirection
            xAngle = Settings.X_MIN_ANGLE * (directionVector.dx / xMaxPixelDirection)
        } else {
            xAngle = Settings.X_MAX_ANGLE * (directionVector.dx / xMaxPixelDirection)
        }
        print(xAngle)
        
        return TossingAngles(xAngle: xAngle, yAngle: yAngle)
        
    }
}
