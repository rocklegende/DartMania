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
    
    func firstPlayerOfGameIsActive() -> Bool {
        return game.players[0]["isActive"] as! Bool
    }
    
    func pointsOfAllPlayersIsSetTo(value: Int) -> Bool {
        let numberOfPlayers = game.settings.getPlayerCount()
        for i in 0..<numberOfPlayers {
            let points = game.players[i]["points"] as! Int
            if (points != value) {
                return false
            }
        }
        return true
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        game = DMGame(settings: DartGameSettings())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        game = nil
    }
    
    func testStoppingGameFinishesIt() {
        game.stop()
        XCTAssert(game.isFinished())
    }
    
    func testThrowing3TimesDecreasesThrowsLeftCorrectly() {
        XCTAssert(game.getThrowsLeft() == 3)
        game.updatePoints(hitPoints: 60)
        XCTAssert(game.getThrowsLeft() == 2)
        game.updatePoints(hitPoints: 80)
        XCTAssert(game.getThrowsLeft() == 1)
        game.updatePoints(hitPoints: 80)
        XCTAssert(game.getThrowsLeft() == 3)
    }
    
    func testOverThrowingResetsThrowsLeftCorrectly() {
        XCTAssert(game.getThrowsLeft() == 3)
        game.updatePoints(hitPoints: 60)
        XCTAssert(game.getThrowsLeft() == 2)
        game.updatePoints(hitPoints: 9999)
        XCTAssert(game.getThrowsLeft() == 3)
    }
    
    func testOverThrowingSwitchesToNextPlayer() {
        let prevCurrentPlayer = game.currentPlayer
        game.updatePoints(hitPoints: game.settings.getMode() + 1)
        let nextCurrentPlayer = game.currentPlayer
        
        XCTAssert(prevCurrentPlayer != nextCurrentPlayer)
        XCTAssertFalse(game.isFinished())
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
        game.updatePoints(hitPoints: 60)
        game.updatePoints(hitPoints: 80)
        game.updatePoints(hitPoints: 61)
        let nextCurrentPlayer = game.currentPlayer
        XCTAssert(prevCurrentPlayer != nextCurrentPlayer)
    }
    
    func testThrowingTwoTimesDoesntSwitchPlayer() {
        let prevCurrentPlayer = game.currentPlayer
        game.updatePoints(hitPoints: 60)
        game.updatePoints(hitPoints: 80)
        let nextCurrentPlayer = game.currentPlayer
        XCTAssert(prevCurrentPlayer == nextCurrentPlayer)
    }
    
    func testSumOfMultipleThrowsIsCorrect() {
        // 501 = 160 + 180 + 161
        game.updatePoints(hitPoints: 160)
        game.updatePoints(hitPoints: 180)
        game.updatePoints(hitPoints: 161)
        XCTAssert(game.isFinished())
    }
    
    func testRestartGame() {
        game.updatePoints(hitPoints: 80)
        game.restart()
        XCTAssert(pointsOfAllPlayersIsSetTo(value: game.settings.getMode()))
        XCTAssert(firstPlayerOfGameIsActive())
    }

}
