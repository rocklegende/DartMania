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
    
    static func getDirectionVector(angles: TossingAngles) -> CGVector {
        
        //TODO: calculate dx
        let dx = UIScreen.main.bounds.size.width * angles.xAngle / Settings.X_MAX_ANGLE
        let dy = UIScreen.main.bounds.size.height * angles.yAngle / Settings.Y_MAX_ANGLE
        
        return CGVector(dx: dx, dy: dy)
    }
}
