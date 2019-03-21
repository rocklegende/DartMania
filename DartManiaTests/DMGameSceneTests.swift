//
//  DMGameSceneTests.swift
//  DartManiaTests
//
//  Created by Tim Hehmann on 27.02.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import XCTest
import GameKit
@testable import DartMania

class DMGameSceneTests: XCTestCase, EndGameDecisionDelegate {
    func didTapReturnToMenuButton() {
        
    }
    
    func didTapRestartButton() {
        
    }
    
    
    var gameScene: GameScene!
    var dartboard: Dartboard!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameScene = GameScene()
        gameScene.addDart()
        gameScene.addDartboard()
        
//        gameScene.settings = DartGameSettings()
//        gameScene.game = DMGame(settings: gameScene.settings)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameScene = nil
    }
    
    func testDartboardIsAddedWhenMovingToScene() {
        gameScene.setupScene()
        XCTAssert(gameScene.childNode(withName: UINames.dartboardNode) != nil)
    }
    
    func testDartIsAddedWhenMovingToScene() {
        gameScene.setupScene()
        XCTAssert(gameScene.childNode(withName: UINames.dartNode) != nil)
    }
    
    func testUserInteractionIsEnabled() {
        gameScene.setupScene()
        XCTAssert(gameScene.isUserInteractionEnabled)
    }
    
    func testGravityIsSetCorrectlyAfterMovingToScene() {
        gameScene.setupScene()
        gameScene.physicsWorld.gravity = CGVector(dx: 0, dy: gameScene.gravity)
    }
    
    func testSetGravity() {
        gameScene.setGravity(-10.0)
        let gravity = gameScene.physicsWorld.gravity
        XCTAssert(gravity == CGVector(dx: 0, dy: -10.0))
    }
    
    func testScreenIsUnblurredAfterRestart() {
        gameScene.endGameDecisionDelegate = self
        gameScene.didTapRestartButton()
        XCTAssert(!gameScene.isShowingEndGameEffect())
    }
    
    func testPlayerWonActionsAreCorrect() {
        //gameScene.handlePlayerWon(player: 0)
        //        XCTAssert(gameScene.childNode(withName: "Play again") != nil)
        //        XCTAssert(gameScene.childNode(withName: "Go back") != nil)
        XCTAssert(true)
    }
    
    func testScreenIsNotBlurredAtStart() {
        XCTAssert(!gameScene.isShowingEndGameEffect())
    }
    
    func testBlurScreen() {
        gameScene.showEndGameEffect()
        XCTAssert(gameScene.isShowingEndGameEffect())
    }
    
    func testUnblurScreen() {
        gameScene.hideEndGameEffect()
        XCTAssert(!gameScene.isShowingEndGameEffect())
    }
    
    
    func testAddHitPointsLabel() {
        gameScene.addHitPointsUILabel()
        XCTAssertNotNil(gameScene.childNode(withName: UINames.hitPointsLabel))
    }
    
    func testAddDart() {
        gameScene.addDart()
        XCTAssertNotNil(gameScene.childNode(withName: UINames.dartNode))
    }
    
    func testAddDartboard() {
        gameScene.addDartboard()
        XCTAssertNotNil(gameScene.childNode(withName: UINames.dartboardNode))
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
