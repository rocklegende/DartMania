//
//  DMGameTests.swift
//  DartManiaTests
//
//  Created by Tim Hehmann on 26.02.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import XCTest
import GameKit
@testable import DartMania

class DMGameTests: XCTestCase {
    var game: DMGame!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        game = DMGame(settings: DartGameSettings())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        game = nil
    }

    func testGettingToZeroPointsFinishesGame() {
        game.updatePoints(hitPoints: game.settings.getMode())
        XCTAssert(game.isFinished())
    }
    
    func testOverThrowingSwitchesToNextPlayer() {
        let prevCurrentPlayer = game.currentPlayer
        game.updatePoints(hitPoints: game.settings.getMode() + 1)
        let nextCurrentPlayer = game.currentPlayer
        
        XCTAssert(prevCurrentPlayer != nextCurrentPlayer)
        XCTAssertFalse(game.isFinished())
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSwitchPlayer() {
        for _ in 1...10 {
            let prevCurrentPlayer = game.currentPlayer
            game.switchToNextPlayer()
            let nextCurrentPlayer = game.currentPlayer
            
            XCTAssertFalse(game.players[prevCurrentPlayer]["isActive"] as! Bool)
            XCTAssert(game.players[nextCurrentPlayer]["isActive"] as! Bool)
        }
    }
    
    func testThrowingThreeTimesSwitchesPlayer() {
        let prevCurrentPlayer = game.currentPlayer
        game.decreaseThrowsLeft()
        game.decreaseThrowsLeft()
        game.decreaseThrowsLeft()
        let nextCurrentPlayer = game.currentPlayer
        XCTAssert(prevCurrentPlayer != nextCurrentPlayer)
    }
    
    func testThrowingTwoTimesDoesntSwitchPlayer() {
        let prevCurrentPlayer = game.currentPlayer
        game.decreaseThrowsLeft()
        game.decreaseThrowsLeft()
        let nextCurrentPlayer = game.currentPlayer
        XCTAssert(prevCurrentPlayer == nextCurrentPlayer)
    }

}
