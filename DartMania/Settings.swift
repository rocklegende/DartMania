//
//  Settings.swift
//  DartMania
//
//  Created by Tim Hehmann on 15.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit

class Settings {
    
    // GAMEPLAY //
    static let availableModes: [String] = ["301", "501", "701"]
    static let availablePlayerCounts: [String] = ["1", "2", "3", "4"]
    
    // DARTBOARD RADIUSESS //
    static let outerRing: CGFloat = 220.0/220.0
    static let outerLabels: CGFloat = 190.0/220.0
    static let outerDoubleWire: CGFloat = 170.0/220.0
    static let doubleRing: CGFloat = 168.5/220.0
    static let innerDoubleWire: CGFloat = 160.5/220.0
    static let outerSingleRing: CGFloat = 159.0/220.0
    static let outerTrippleWire: CGFloat = 107.0/220.0
    static let trippleRing: CGFloat = 105.5/220.0
    static let innerTrippleWire: CGFloat = 97.5/220.0
    static let innerSingleRing: CGFloat = 96.0/220.0
    static let halfBullsEyeWire: CGFloat = 17.4/220.0
    static let halfBullsEye: CGFloat = 15.9/220.0
    static let bullsEyeWire: CGFloat = 7.85/220.0
    static let bullsEye: CGFloat = 6.35/220.0
    
    // FONT //
    static let pointLabelFontSize: CGFloat = 40
    
    // DEFAULTS SIZES//
    static let defaultCenter: CGPoint = CGPoint(x: 0, y: UIScreen.main.bounds.height * 0.4)
    static let defaultDartBoardRadius: CGFloat = UIScreen.main.bounds.width
    
    // POINTS //
    static let pointsArray: [Int] = [13, 4, 18, 1, 20, 5, 12, 9, 14, 11, 8, 16, 7, 19, 3, 17, 2, 15, 10, 6]
    
    // MAX-MIN ANGLES //
    static let X_MAX_ANGLE: CGFloat = 30.0
    static let X_MIN_ANGLE: CGFloat = -30.0
    static let Y_MAX_ANGLE: CGFloat = 45.0
    static let Y_MIN_ANGLE: CGFloat = 10.0

    // COLORS //
    static let dartBoardGreen: UIColor = UIColor(red: 48.0/255.0, green: 159.0/255.0, blue: 106.0/255.0, alpha: 1.0)
    static let dartBoardBlack: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    static let dartBoardWhite: UIColor = UIColor(red: 249.0/255.0, green: 223.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    static let dartBoardRed: UIColor = UIColor(red: 227.0/255.0, green: 41.0/255.0, blue: 46.0/255.0, alpha: 1.0)
}
