//
//  Settings.swift
//  DartMania
//
//  Created by Tim Hehmann on 15.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit

class Settings {
    
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
