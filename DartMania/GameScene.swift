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
    var settings: DartGameSettings!
    var throwsLeft: Int = 3
    var pointsMadeInCurrentThrow: Int = 0
    var currentPlayer: Int = 0
    
    private var dart: Dart!
    private var dartboard: Dartboard!
    private var label: SKLabelNode!
    
    private var pointsLeft: [Int] = []
    private var pointsLeftLabels: [UILabel] = []
    
    private var swipeStartPoint: CGPoint?
    private var swipeEndPoint: CGPoint?
    
    override func didMove(to view: SKView) {
        
        if let gameSettings = self.userData?.value(forKey: "gameSettings") as? DartGameSettings {
            settings = gameSettings
            
            let bla = settings!.getPlayerCount()
            for _ in 0..<bla {
                pointsLeft.append(settings!.getMode())
                addPointsLeftLabel(text: String(settings!.getMode()))
            }
        }
        
        
        
        
        
        self.isUserInteractionEnabled = true
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -20.0)
        
        self.dartboard = Dartboard(gameScene: self, center: Settings.defaultCenter, radius: 320)
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
            //print(dartboard.getHitPoints(point: touchPoint))
            if (dart.node.contains(touchPoint)) {
                swipeStartPoint = touchPoint
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
                
                let angles = Helper.getAngles(directionVector: directionVector)
                
                dart.toss(angles: angles)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                    let dartTouchPoint = CGPoint(x: self.dart.node.frame.minX, y: self.dart.node.frame.minY)
                    
                    let hitPoints = self.dartboard.getHitPoints(point: dartTouchPoint)
                    self.label.text = "\(hitPoints)"
                    
                    
                    if (self.pointsMadeInCurrentThrow + hitPoints < self.pointsLeft[self.currentPlayer]) {
                        self.pointsMadeInCurrentThrow += hitPoints
                        self.pointsLeft[self.currentPlayer] -= hitPoints
                        self.pointsLeftLabels[self.currentPlayer].text = "\(self.pointsLeft[self.currentPlayer])"
                    } else if (self.pointsMadeInCurrentThrow + hitPoints == self.pointsLeft[self.currentPlayer]) {
                        // TODO: check if double
                        self.pointsLeft[self.currentPlayer] -= hitPoints
                        print("Player \(self.currentPlayer + 1) won!")
                    } else {
                        self.switchToNextPlayer()
                    }
                    
                    self.throwsLeft -= 1
                    if (self.throwsLeft == 0) {
                        self.switchToNextPlayer()
                    }
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
    
    func addPointsLeftLabel(text: String) {
        let label = UILabel()
        label.text = text
        self.view!.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if (pointsLeftLabels.count == 0) {
            label.centerYAnchor.constraint(equalTo: (self.view?.centerYAnchor)!).isActive = true
        } else {
            label.topAnchor.constraint(equalTo: (pointsLeftLabels.last?.bottomAnchor)!).isActive = true
        }
        label.leftAnchor.constraint(equalTo: self.view!.leftAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        pointsLeftLabels.append(label)
    }
    
    func switchToNextPlayer() {
        throwsLeft = 3
        
        currentPlayer += 1
        if currentPlayer == settings.getPlayerCount() {
            currentPlayer = 0
        }
        pointsMadeInCurrentThrow = 0
        
        
    }
    
    
}
