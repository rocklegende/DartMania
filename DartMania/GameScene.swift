//
//  GameScene.swift
//  DartMania
//
//  Created by Tim Hehmann on 16.09.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import SpriteKit
import GameplayKit

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
        setSettings()
        self.scaleMode = .aspectFit
        self.isUserInteractionEnabled = true
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -20.0)
        
        // ADD DARTBOARD //
        self.dartboard = Dartboard(center: Settings.defaultCenter, radius: Settings.defaultDartBoardRadius)
        self.addChild(dartboard.node)
        
        // ADD DART //
        self.dart = Dart()
        self.addChild(dart.node!)
        
        // ADD HIT POINTS LABEL //
        self.label = SKLabelNode(text: "Points: ")
        self.label.fontSize = 60
        self.label.position = CGPoint(x: 0, y: -400)
        self.addChild(self.label)
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
                dart.toss(angles: angles) { (successfulThrow) in
                    if (successfulThrow) {
                        self.evaluateThrow()
                        //self.resetPositionOfDart()
                        self.resetSwipePoints()
                    }
                }
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
    
    func performDartThrow() {
        
    }
    
    func evaluateThrow() {
        let dartTouchPoint = CGPoint(x: dart.node.frame.minX, y: dart.node.frame.minY)
        
        let hitPoints = dartboard.getHitPoints(point: dartTouchPoint)
        label.text = "\(hitPoints)"
        
        updatePoints(player: currentPlayer, hitPoints: hitPoints)
        
        throwsLeft -= 1
        if (throwsLeft == 0) {
            switchToNextPlayer()
        }
    }
    
    func setSettings() {
        // SET SETTINGS//
        if let gameSettings = self.userData?.value(forKey: "gameSettings") as? DartGameSettings {
            settings = gameSettings
            let numberOfPlayers = settings!.getPlayerCount()
            for _ in 0..<numberOfPlayers {
                addPointsLeftForNewPlayer()
                addPointsLeftLabel(text: String(settings!.getMode()))
            }
            pointsLeftLabels.first?.textColor = .white
        }
    }
    
    func updatePoints (player: Int, hitPoints: Int) {
        if (pointsMadeInCurrentThrow + hitPoints < pointsLeft[player]) {
            pointsMadeInCurrentThrow += hitPoints
            pointsLeft[player] -= hitPoints
            pointsLeftLabels[player].text = "\(pointsLeft[player])"
        } else if (pointsMadeInCurrentThrow + hitPoints == pointsLeft[player]) {
            // TODO: check if double
            pointsLeft[player] -= hitPoints
            print("Player \(player + 1) won!")
        } else {
            switchToNextPlayer()
        }
    }
    
    func resetSwipePoints() {
        swipeStartPoint = nil
        swipeEndPoint = nil
    }
    
    func resetThrowsLeft() {
        self.throwsLeft = 3
    }
    
    func addPointsLeftLabel(text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = .red
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
    
    func addPointsLeftForNewPlayer() {
        pointsLeft.append(settings!.getMode())
    }
    
    func switchToNextPlayer() {
        
        pointsLeftLabels[currentPlayer].textColor = .red
        
        currentPlayer += 1
        if currentPlayer == settings.getPlayerCount() {
            currentPlayer = 0
        }
        pointsLeftLabels[currentPlayer].textColor = .white
        
        resetThrowsLeft()
        pointsMadeInCurrentThrow = 0
    }
    
    
}
