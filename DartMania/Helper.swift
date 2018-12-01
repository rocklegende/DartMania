//
//  Helper.swift
//  DartMania
//
//  Created by Tim Hehmann on 26.09.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import Foundation
import GameplayKit

class Helper {
    static func cap(value: CGFloat, max: CGFloat, min: CGFloat) -> CGFloat {
        if value > max {
            return max
        }
        if value < min {
            return min
        }
        return value
    }
    
    static func vectorToAngle(directionVector: CGVector, maxVector: CGFloat, minVector: CGFloat, maxAngle: CGFloat, minAngle: CGFloat) {
        
    }
    static func angleToVector(angle: CGFloat, maxVector: CGFloat, minVector: CGFloat, maxAngle: CGFloat, minAngle: CGFloat) {
        
    }
}
