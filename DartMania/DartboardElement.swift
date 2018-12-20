//
//  DartboardElement.swift
//  DartMania
//
//  Created by Tim Hehmann on 21.10.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import GameplayKit

class DartboardElement {

    var points: Int
    var field: CAShapeLayer
    
    init(points: Int) {
        self.points = points
        self.field = CAShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
