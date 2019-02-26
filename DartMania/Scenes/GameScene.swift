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
    private var dart: Dart!
    private var dartboard: Dartboard!
    private var label: SKLabelNode!
    private var pointsLeftLabels: [UILabel] = []
    private var swipeStartPoint: CGPoint?
    private var swipeEndPoint: CGPoint?
    @objc private var game: DMGame!
    private var observations: [NSKeyValueObservation] = []
    
    var settings: DartGameSettings!
    
    override func didMove(to view: SKView) {
        setConfig()
        setDartGameSettings()
        setGravity(gravity: -20.0)
        game = DMGame(settings: settings)
        startGamePropertyObservations()

        addPointsLeftLabels()
        addDartboard()
        addDart()
        addHitPointsUILabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            if (dart.node.contains(touchPoint)) {
                swipeStartPoint = touchPoint
            } else {
                print("You didnt touch the dartarrow")
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
                performDartThrow()
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
    
    func startGamePropertyObservations() {
        let playerObservation = game.observe(\.players) { (game, change) in
            self.handleGameStateChange()
        }
        let isGameFinishedObservation = game.observe(\.finished) { (game, change) in
            if (game.finished) {
                self.handlePlayerWon(player: game.currentPlayer)
            }
        }
        observations.append(playerObservation)
        observations.append(isGameFinishedObservation)
    }
    
    func handleGameStateChange() {
        for i in 0..<game.players.count {
            pointsLeftLabels[i].text = "\(game.players[i]["points"] as! Int)"
            if (game.players[i]["isActive"] as! Bool) {
                pointsLeftLabels[i].textColor = .white
            } else {
                pointsLeftLabels[i].textColor = .red
            }
        }
    }
    
    func setConfig() {
        self.isUserInteractionEnabled = true
    }
    
    func setGravity(gravity: CGFloat) {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity)
    }
    
    func addHitPointsUILabel() {
        self.label = SKLabelNode(text: "")
        self.label.fontSize = 60
        self.label.position = CGPoint(x: 0, y: -400)
        self.addChild(self.label)
    }
    
    func addDart() {
        self.dart = Dart()
        self.addChild(dart.node!)
    }
    
    func addDartboard() {
        self.dartboard = Dartboard()
        self.addChild(dartboard.node)
    }
    
    func performDartThrow() {
        let directionVector = Helper.getDirectionVectorFromSwipePoints(startPoint: swipeStartPoint!, endPoint: swipeEndPoint!)
        let angles = Helper.getAngles(directionVector: directionVector)
        dart.toss(angles: angles) { (successfulThrow) in
            if (successfulThrow) {
                self.handleCompletedThrow()
            }
        }
    }
    
    
    
    func handleCompletedThrow() {
        self.evaluateThrow()
        //self.resetPositionOfDart()
        self.resetSwipePoints()
    }
    
    func evaluateThrow() {
        let dartTouchPoint = CGPoint(x: dart.node.frame.minX, y: dart.node.frame.minY)
        let hitPoints = dartboard.getHitPoints(point: dartTouchPoint)
        label.text = "\(hitPoints)"
        
        game.updatePoints(hitPoints: hitPoints)
        game.decreaseThrowsLeft()
    }
    
    func setDartGameSettings() {
        if let gameSettings = self.userData?.value(forKey: "gameSettings") as? DartGameSettings {
            settings = gameSettings
        }
    }
    
    func addPointsLeftLabels() {
        let numberOfPlayers = settings!.getPlayerCount()
        for _ in 0..<numberOfPlayers {
            addPointsLeftLabel(text: String(settings!.getMode()))
        }
        pointsLeftLabels.first?.textColor = .white
    }
    
    func resetSwipePoints() {
        swipeStartPoint = nil
        swipeEndPoint = nil
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
    
    func handlePlayerWon(player: Int) {
        blurScreen()
        //showEndOfGameScreen() (#1)
        addReplayButton(player: player)
        addGoBackToMenuButton()
    }
    
    func blurScreen() {
        let  blur = CIFilter(name:"CIGaussianBlur",withInputParameters: ["inputRadius": 10.0])
        self.filter = blur
        self.shouldRasterize = true
        self.shouldEnableEffects = true
    }
    
    func removeBlur() {
        self.filter = nil
    }
    
    func isBlurred() -> Bool {
        return self.filter?.name == "CIGaussianBlur"
    }
    
    @objc func restartGame() {
        removeBlur()
    }
    
    @objc func goBackToMenu() {
        self.removeFromParent()
        self.view?.presentScene(nil)
    }
    
    func addWinnerMessage(player: Int) {
        let label = DMCustomControlsFactory.createLabel(withText: "\(player + 1) won!")
        self.view?.addSubview(label)
    }
    
    func addReplayButton(player: Int) {
        let button = DMCustomControlsFactory.createButton(withTitle: "Play again", withWidthInPercent: 0.4)
        self.view?.addSubview(button)
        button.rightAnchor.constraint(equalTo: view!.centerXAnchor, constant: -5).isActive = true
        button.bottomAnchor.constraint(equalTo: view!.bottomAnchor, constant: -view!.bounds.height * 0.2).isActive = true
        button.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        
        let label = DMCustomControlsFactory.createLabel(withText: "Player \(player + 1) won!")
        self.view?.addSubview(label)
        label.topAnchor.constraint(equalTo: view!.topAnchor, constant: view!.bounds.height * 0.4).isActive = true
        label.widthAnchor.constraint(equalTo: view!.widthAnchor, multiplier: 0.7).isActive = true
        label.centerXAnchor.constraint(equalTo: view!.centerXAnchor).isActive = true
        
    }
    
    func addGoBackToMenuButton() {
        let button = DMCustomControlsFactory.createButton(withTitle: "Go back", withWidthInPercent: 0.4)
        self.view?.addSubview(button)
        button.leftAnchor.constraint(equalTo: view!.centerXAnchor, constant: 5).isActive = true
        button.bottomAnchor.constraint(equalTo: view!.bottomAnchor, constant: -view!.bounds.height * 0.2).isActive = true
        button.addTarget(self, action: #selector(goBackToMenu), for: .touchUpInside)
    }
}


/*
 Ideen fuer bessere Struktur:
 - #1: es gibt einen endGameView, der die Buttons hat und noch Statistiken zum Spiel etc.
 
 */
