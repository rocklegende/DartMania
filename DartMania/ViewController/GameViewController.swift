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

class GameViewController: UIViewController, EndGameDecisionDelegate {
    func didTapReturnToMenuButton() {
        navigationController?.popViewController(animated: true)
        removeFromParentViewController()
        dismiss(animated: true, completion: nil)
        if let view = self.view as! SKView? {
            view.presentScene(nil)
            
        }
    }
    
    var settings: DartGameSettings?
    var game: DMGame?
    
    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "gameView"
        
        if let view = self.view as! SKView? {
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // get notified if the presented game wants to return to the menu
                scene.endGameDecisionDelegate = self
                
                scene.userData = NSMutableDictionary()
                scene.userData?.setObject(settings ?? DartGameSettings(), forKey: "gameSettings" as NSCopying)
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let view = self.view as! SKView? {
            view.presentScene(nil)
        }
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
