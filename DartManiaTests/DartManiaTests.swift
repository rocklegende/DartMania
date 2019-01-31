//
//  DartManiaTests.swift
//  DartManiaTests
//
//  Created by Tim Hehmann on 03.01.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import XCTest
import GameKit
@testable import DartMania

class DartManiaTests: XCTestCase {
    
    var gameScene: GameScene!
    var dartboard: Dartboard!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameScene = GameScene()
        dartboard = Dartboard(center: CGPoint(x: 0, y: 200), radius: 100)
        gameScene.settings = DartGameSettings()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameScene = nil
    }

    func testResetThrowsLeft() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        gameScene.throwsLeft = 0
        gameScene.resetThrowsLeft()
        XCTAssert(gameScene.throwsLeft == 3)
        
    }
    
    func testGetDirectionVector() {
        let angles = TossingAngles(xAngle: 0, yAngle: 0)
        XCTAssert(Helper.getDirectionVector(angles: angles) == CGVector(dx: 0, dy: 0))
    }
    
    func testGetAngles() {
        let dv = CGVector(dx: 0, dy: 0)
        XCTAssert(Helper.getAngles(directionVector: dv).xAngle == TossingAngles(xAngle: 0, yAngle: 0).xAngle)
        XCTAssert(Helper.getAngles(directionVector: dv).yAngle == TossingAngles(xAngle: 0, yAngle: 0).yAngle)
    }
    
    func testDartboardHas20FieldLabels() {
        var count = 0
        for element in dartboard.node.children {
            if let _ = element as? SKLabelNode {
                count += 1
            }
        }
        XCTAssertTrue(count == 20)
    }
    
    func testSwitchPlayer() {
        gameScene.currentPlayer = 0
        for _ in 1...10 {
            gameScene.increaseCurrentPlayer()
            XCTAssert(gameScene.currentPlayer < gameScene.settings.getPlayerCount())
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
