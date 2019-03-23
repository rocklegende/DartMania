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

class DMHelperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCapsValueThatIsTooHigh() {
        let overSizedValue = CGFloat(101)
        let cappedValue = Helper.cap(value: overSizedValue, max: 100, min: 0)
        XCTAssert(cappedValue == CGFloat(100))
    }
    
    func testCapsValueThatIsTooLow() {
        let overSizedValue = CGFloat(-101)
        let cappedValue = Helper.cap(value: overSizedValue, max: 100, min: -100)
        XCTAssert(cappedValue == CGFloat(-100))
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
}
