//
//  DartManiaUITests.swift
//  DartManiaUITests
//
//  Created by Tim Hehmann on 31.01.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import XCTest

class DartManiaUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClickOnStartOpensGameSettings() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.buttons["startNewGameButton"].tap()
        XCTAssertTrue(app.otherElements["gameSettingsView"].exists);
    }
    
    func testClickOnStartLocalGameOpensGame() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.buttons["startNewGameButton"].tap()
        app.buttons["Start local game"].tap()
        XCTAssertTrue(app.otherElements["gameView"].exists);
    }

}
