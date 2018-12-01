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
    private var dart: DartNode?
    private var dartboard: Dartboard?
    
    override func didMove(to view: SKView) {
        
        self.dart = DartNode(circleOfRadius: 100)
        self.addChild(self.dart!)
        
        self.dartboard = Dartboard()
        self.addChild(self.dartboard!)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
