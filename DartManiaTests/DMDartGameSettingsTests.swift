//
//  DMDartGameSettingsTests.swift
//  DartManiaTests
//
//  Created by Tim Hehmann on 09.03.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import XCTest
@testable import DartMania

class DMDartGameSettingsTests: XCTestCase {
    
    var gameSettings: DartGameSettings!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameSettings = DartGameSettings()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameSettings = nil
    }
    
    func testSetModeToUnavailableMode() {
        gameSettings.setMode(points: 1000)
        XCTAssert(gameSettings.getMode() == 501)
    }
    
    func testSetModeToAvailableMode() {
        gameSettings.setMode(points: 301)
        XCTAssert(gameSettings.getMode() == 301)
    }
    
    func testSetPlayerNumberToUnavailableNumber() {
        let unavailableNumber = 1000 //we can be sure, that 1000 players will never be supported
        gameSettings.setNumberOfPlayers(unavailableNumber)
        XCTAssert(gameSettings.getPlayerCount() == 2)
    }
    
    func testSetPlayerNumberToAvailableNumber() {
        let availableNumber = Int(Settings.availablePlayerCounts.last!)!
        gameSettings.setNumberOfPlayers(availableNumber)
        XCTAssert(gameSettings.getPlayerCount() == availableNumber)
    }
}
