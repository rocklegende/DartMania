//
//  DMDartTests.swift
//  DartManiaTests
//
//  Created by Tim Hehmann on 21.03.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import XCTest
@testable import DartMania

class DMDartTests: XCTestCase {
    
    var dart: Dart!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dart = Dart()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dart = nil
    }
    
    func testDartIsFlyingAfterTouchStartAtDartAndTouchEnd() {
        dart.handleTouchBegin(dart.position) // a point inside the dart node
        dart.handleTouchEnd(dart.position)
        XCTAssert(dart.isFlying())
    }
    
    func testActionsAfterDartHitAreCorrect() {
        dart.performActionsAfterDartHitTheDartboard()
        XCTAssert(dart.isOnDartboard)
        XCTAssert(dart.physicsBody?.velocity == CGVector(dx: 0, dy: 0))
        XCTAssertFalse(dart.physicsBody!.affectedByGravity)
        XCTAssertFalse(dart.isFlying())
    }

}
