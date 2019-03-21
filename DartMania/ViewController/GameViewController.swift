//
//  GameViewController.swift
//  DartMania
//
//  Created by Tim Hehmann on 16.09.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var game: DMGame!
    var scene: GameScene?
    private var observations: [NSKeyValueObservation] = []
    
    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "gameView"
        startGamePropertyObservations()
        
        if let view = self.view as! SKView? {
            if let scene = GameScene(fileNamed: "GameScene") {
                self.scene = scene
                setupScene()
                view.presentScene(scene)
                scene.initSceneFromGame(game!)
            }
            view.ignoresSiblingOrder = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopGamePropertyObservations()
        if let view = self.view as! SKView? {
            view.presentScene(nil)
        }
    }
    
    func setupScene() {
        scene!.scaleMode = .aspectFit
        scene!.endGameDecisionDelegate = self
        scene!.dartThrowDelegate = self
    }
    
    func presentScene() {
        
    }
    
    func startGamePropertyObservations() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGameStateChange), name: Notification.Name("didChangeState"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPlayerChange), name: Notification.Name("didSwitchPlayer"), object: nil)
        
        
        let isGameFinishedObservation = game.observe(\.isOver) { (game, change) in
            if (game.isOver) {
                self.scene!.handlePlayerWon(player: game.currentPlayer)
            }
        }
        observations.append(isGameFinishedObservation)
    }
    
    @objc func onGameStateChange() {
        self.scene!.updateStateAccordingTo(game)
    }
    
    @objc func onPlayerChange() {
        self.scene!.handleChangeOfPlayer()
    }
    
    internal func stopGamePropertyObservations() {
        observations = []
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

extension GameViewController : EndGameDecisionDelegate {
    func didTapRestartButton() {
        game.restart()
    }
    
    func didTapReturnToMenuButton() {
        navigationController?.popViewController(animated: true)
        removeFromParentViewController()
        dismiss(animated: true, completion: nil)
        if let view = self.view as! SKView? {
            view.presentScene(nil)
        }
    }
}

extension GameViewController : DartThrowDelegate {
    
    func dartDidTouchDartboard(dart: Dart) {
        //
    }
    
    func didEvaluateThrow(hitPoints: Int) {
        game?.updatePoints(hitPoints: hitPoints)
    }
}
