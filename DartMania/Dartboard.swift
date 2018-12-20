//
//  Dartboard.swift
//  DartMania
//
//  Created by Tim Hehmann on 21.10.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import GameplayKit

class Dartboard {

    // var elements = 0
    // var numberOfFields: Int = 0
    
    var gameScene: SKScene?
    
    init(gameScene: SKScene) {
        self.gameScene = gameScene
        createSingleArc()
    }
    
    func createSingleArc() {
        let outerArc = SKShapeNode()
        let path = UIBezierPath(arcCenter: CGPoint(x: 100, y: 200), radius: 30, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true).cgPath
        outerArc.path = path
        outerArc.fillColor = UIColor.red
        outerArc.strokeColor = UIColor.red
        gameScene?.addChild(outerArc)
        
        let innerArc = SKShapeNode()
        innerArc.path = UIBezierPath(arcCenter: CGPoint(x: 100, y: 200), radius: 20, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true).cgPath
        innerArc.fillColor = UIColor.black
        innerArc.fillColor = UIColor.black
        gameScene?.addChild(innerArc)
    }
    
    func getHitPoints(point: CGPoint) -> Int {
        /*
        guard let sublayers = self.view!.layer.sublayers as? [CAShapeLayer] else { return -1 }
        for layer in sublayers {
            if (layer.path?.contains(point))! {
                // return layer.points
                return 10
            }
        }
         */
        return 0
 
    }
    
    
//    func createDartboardElements () {
//
//        let circlePath = UIBezierPath(ovalIn: CGRect(x: 200, y: 200, width: 150, height: 150))
//        var segments: [CAShapeLayer] = []
//        //let segmentAngle: CGFloat = (360 * 0.125) / 360
//        let segmentAngle: CGFloat = CGFloat(1 / numberOfFields)
//
//        //create bulls eye
//        //create second bulls eye
//        //create outer edge
//
//        for i in 0..<numberOfFields {
//
//            // create inner -> 1x
//            let inner1x = SKNode()
//            let circle = SKShapeNode()
//            let circleLayer = CAShapeLayer()
//            circleLayer.path = circlePath.cgPath
//
//
//            // start angle is number of segments * the segment angle
//            circleLayer.strokeStart = segmentAngle * CGFloat(i)
//
//            // end angle is the start plus one segment, minus a little to make a gap
//            // you'll have to play with this value to get it to look right at the size you need
//            let gapSize: CGFloat = 0.008
//            circleLayer.strokeEnd = circleLayer.strokeStart + segmentAngle - gapSize
//
//            circleLayer.lineWidth = 10
//            circleLayer.strokeColor = UIColor(red:0,  green:0.004,  blue:0.549, alpha:1).cgColor
//            circleLayer.fillColor = UIColor.clear.cgColor
//
//            // add the segment to the segments array and to the view
//            segments.append(circleLayer)
//            // self.layer.addSublayer(segments[i])
//
//
//
//
//
//            // create 3x
//            let trippleField = SKShapeNode()
//            // create outer -> 1x
//            let outer1x = SKShapeNode()
//            // create double
//            let doubleField = SKShapeNode()
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
