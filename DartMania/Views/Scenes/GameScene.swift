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
    private var dartboard: Dartboard!
    private var hitPointsLabel: SKLabelNode?
    private var pointsLeftLabels: [UILabel] = []
    private var endGameVisualEffect = CIFilter(name:"CIGaussianBlur",withInputParameters: ["inputRadius": 10.0])
    private var waitTimeAfterEachThrow: TimeInterval = 1
    
    weak var endGameDecisionDelegate: EndGameDecisionDelegate!
    weak var dartThrowDelegate: DartThrowDelegate?
    
    var gravity: CGFloat {
        get { return -50.0 }
    }
    
    override func didMove(to view: SKView) {
        setupScene()
    }
    
    func setupScene() {
        setGravity(self.gravity)
        addDartboard()
        addHitPointsUILabel()
    }
    
    func initSceneFromGame(_ game: DMGame) {
        let numberOfPlayers = game.players.count
        for _ in 0..<numberOfPlayers {
            addPointsLeftLabel(text: "")
        }
        updateStateAccordingTo(game)
    }
    
    fileprivate func removeAllDartsFromDartBoard() {
        for childNode in children {
            if let dart = childNode as? Dart {
                if (dart.isOnDartboard) {
                    dart.removeFromParent()
                }
            }
        }
    }
    
    func updateStateAccordingTo(_ game: DMGame) {
        for i in 0..<game.players.count {
            pointsLeftLabels[i].text = "\(game.players[i]["points"] as! Int)"
            if (game.players[i]["isActive"] as! Bool) {
                pointsLeftLabels[i].textColor = .white
            } else {
                pointsLeftLabels[i].textColor = .red
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.addDart()
        })
    }
    
    func setGravity(_ gravity: CGFloat) {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity)
    }
    
    func addHitPointsUILabel() {
        self.hitPointsLabel = SKLabelNode(text: "")
        self.hitPointsLabel!.name = UINames.hitPointsLabel
        self.hitPointsLabel!.fontSize = 60
        self.hitPointsLabel!.position = CGPoint(x: 0, y: -400)
        self.addChild(self.hitPointsLabel!)
    }
    
    func addDart() {
        let dart = Dart()
        dart.dartThrowDelegate = self
        self.addChild(dart)
    }
    
    func addDartboard() {
        self.dartboard = Dartboard()
        self.addChild(dartboard.node)
    }
    
    func evaluateThrowOfDart(dart: Dart) {
        let dartTouchPoint = CGPoint(x: dart.frame.minX, y: dart.frame.minY)
        let hitPoints = dartboard.getHitPoints(point: dartTouchPoint)
        
        precondition(
            hitPoints >= 0 && hitPoints <= 3 * Settings.pointsArray.max()!,
            "you can't throw points that are < 0 or > \(Settings.pointsArray.max()! * 3)"
        )
        hitPointsLabel?.text = "\(hitPoints)"
        dartThrowDelegate?.didEvaluateThrow(hitPoints: hitPoints)
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
        showEndGameEffect()
        showEndGameScreen()
    }
    
    func showEndGameScreen() {
        let endGameView = DMEndGameView(frame: (self.view?.frame)!)
        endGameView.endGameDecisionDelegate = self
        self.view?.addSubview(endGameView)
    }
    
    func showEndGameEffect() {
        self.filter = endGameVisualEffect
        self.shouldRasterize = true
        self.shouldEnableEffects = true
    }
    
    func hideEndGameEffect() {
        self.filter = nil
    }
    
    func isShowingEndGameEffect() -> Bool {
        return self.filter != nil
    }
    
    override func willMove(from view: SKView) {
        cleanUp()
    }
    
    internal func cleanUp() {
        self.removeAllChildren()
    }
    
    func handleChangeOfPlayer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.removeAllDartsFromDartBoard()
        }
    }
}

extension GameScene : EndGameDecisionDelegate {
    func didTapRestartButton() {
        hideEndGameEffect()
        endGameDecisionDelegate.didTapRestartButton()
    }
    
    func didTapReturnToMenuButton() {
        self.removeFromParent()
        self.view?.presentScene(nil)
        endGameDecisionDelegate.didTapReturnToMenuButton()
    }
}

extension GameScene : DartThrowDelegate {
    func didEvaluateThrow(hitPoints: Int) {
        //
    }
    
    func dartDidTouchDartboard(dart: Dart) {
        self.evaluateThrowOfDart(dart: dart)
    }
}
