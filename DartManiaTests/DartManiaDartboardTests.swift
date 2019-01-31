//
//  DartManiaDartboardTests.swift
//  DartManiaTests
//
//  Created by Tim Hehmann on 31.01.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import XCTest
import GameKit
@testable import DartMania

class DartManiaDartboardTests: XCTestCase {

    var dartboard: Dartboard!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dartboard = Dartboard(center: CGPoint(x: 0, y: 200), radius: 100)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dartboard = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
    
    func testDartboardHas280Parts() {
        // 20 fields a 14 elements
        XCTAssertTrue(dartboard.node.children.count == 280)
    }
    
    func testWidthOfDartboardIs80Percent() {
        
    }
    
    func testDartboardIsVisibleAtCreation() {
        XCTAssertFalse(dartboard.node.isHidden)
    }
    
    func testDartboardHasUserInteractionDisabled() {
        XCTAssertFalse(dartboard.node.isUserInteractionEnabled)
    }
    
    func testReturnNoPointsAtEdge() {
        
    }
    
    func testReturn50AtHitInCenter() {
        let points = dartboard.getHitPoints(point: dartboard.center)
        XCTAssertTrue(points == 50)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
