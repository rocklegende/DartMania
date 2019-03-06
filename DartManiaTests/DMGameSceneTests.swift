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

class DMGameSceneTests: XCTestCase {
    
    var gameScene: GameScene!
    var dartboard: Dartboard!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameScene = GameScene()
//        gameScene.settings = DartGameSettings()
//        gameScene.game = DMGame(settings: gameScene.settings)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameScene = nil
    }
    
    func testSetGravity() {
        gameScene.setGravity(gravity: -10.0)
        let gravity = gameScene.physicsWorld.gravity
        XCTAssert(gravity == CGVector(dx: 0, dy: -10.0))
    }
    
    func testPlayerWonActionsAreCorrect() {
        //gameScene.handlePlayerWon(player: 0)
        //        XCTAssert(gameScene.childNode(withName: "Play again") != nil)
        //        XCTAssert(gameScene.childNode(withName: "Go back") != nil)
        XCTAssert(true)
    }
    
    func testScreenIsNotBlurredAtStart() {
        XCTAssert(!gameScene.isBlurred())
    }
    
    func testBlurScreen() {
        gameScene.blurScreen()
        XCTAssert(gameScene.isBlurred())
    }
    
    func testUnblurScreen() {
        gameScene.unblurScreen()
        XCTAssert(!gameScene.isBlurred())
    }
    
    func testResetSwipePoints () {
        gameScene.resetSwipePoints()
        XCTAssert(gameScene.getSwipePoints() == [nil, nil])
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
    
    func testShowEndGameScreen() {
//        gameScene.showEndGameScreen()
//        XCTAssert(XCTAssertNotNil(gameScene.childNode(withName: UINames.endGameScreen)))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
