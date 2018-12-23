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
    var node: SKShapeNode
    
    init(points: Int, path: UIBezierPath, color: UIColor) {
        self.points = points
        self.node = SKShapeNode()
        self.node.path = path.cgPath
        self.node.fillColor = color
        self.node.strokeColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
