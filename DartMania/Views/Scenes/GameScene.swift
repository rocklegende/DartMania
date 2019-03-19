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
    var dart: Dart!
    private var dartboard: Dartboard!
    private var hitPointsLabel: SKLabelNode?
    private var pointsLeftLabels: [UILabel] = []
    private var swipeStartPoint: CGPoint?
    private var swipeEndPoint: CGPoint?
    private var endGameVisualEffect = CIFilter(name:"CIGaussianBlur",withInputParameters: ["inputRadius": 10.0])
    
    weak var endGameDecisionDelegate: EndGameDecisionDelegate!
    weak var dartThrowDelegate: DartThrowDelegate?
    
    var gravity: CGFloat {
        get { return -50.0 }
    }
    
    override func didMove(to view: SKView) {
        setupScene()
    }
    
    func setupScene() {
        setConfig()
        setGravity(self.gravity)
        addDartboard()
        addDart()
        addHitPointsUILabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            handleTouchBegin(touchPoint)
        } else {
            print("error getting first touch position of dragevent")
        }
    }
    
    internal func handleTouchBegin(_ touchPoint: CGPoint) {
        if (dart.node.contains(touchPoint)) {
            swipeStartPoint = touchPoint
        } else {
            print("You didnt touch the dartarrow")
        }
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
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
    
    func initSceneFromGame(_ game: DMGame) {
        let numberOfPlayers = game.players.count
        for _ in 0..<numberOfPlayers {
            addPointsLeftLabel(text: "")
        }
        updateStateAccordingTo(game)
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
    }
    
    func setConfig() {
        self.isUserInteractionEnabled = true
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
        
        blockInteractionWithDartArrow()
        dart.toss(angles: angles) { (successfulThrow) in
            if (successfulThrow) {
                self.handleCompletedThrow()
            }
        }
    }
    
    func blockInteractionWithDartArrow() {
        isUserInteractionEnabled = false
    }
    
    func activateInteractionWithDartArrow() {
        isUserInteractionEnabled = true
    }
    
    func handleCompletedThrow() {
        self.evaluateThrow()
        self.resetSwipePoints()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.dart.resetToStartPosition()
            self.activateInteractionWithDartArrow()
            self.dart.resetToNormalSize()
        })
    }
    
    func evaluateThrow() {
        let dartTouchPoint = CGPoint(x: dart.node.frame.minX, y: dart.node.frame.minY)
        let hitPoints = dartboard.getHitPoints(point: dartTouchPoint)
        
        precondition(
            hitPoints >= 0 && hitPoints <= 3 * Settings.pointsArray.max()!,
            "you can't throw points that are < 0 or > \(Settings.pointsArray.max()! * 3)"
        )
        hitPointsLabel?.text = "\(hitPoints)"
        dartThrowDelegate?.didEvaluateThrow(hitPoints: hitPoints)
    }
    
    func resetSwipePoints() {
        swipeStartPoint = nil
        swipeEndPoint = nil
    }
    
    internal func getSwipePoints() -> [CGPoint?] {
        return [swipeStartPoint, swipeEndPoint]
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
