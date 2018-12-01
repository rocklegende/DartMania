//
//  DartboardElement.swift
//  DartMania
//
//  Created by Tim Hehmann on 21.10.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import GameplayKit

class DartboardElement: SKShapeNode {

    private var points: Int
    
    init(points: Int) {
        super.init()
        self.points = points
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
