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
    
    func addField (points: Int) {
        // - look in array what the position of the points is
        // - according to that position get the right starting and end angles for the arc
        // - create 2x field
        // - create outer 1x field
        // - create 3x field
        // - create inner 1x field
        // if bullseye create dots..
    }
    
    func addSingleField (points: Int, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, color: UIColor) {
        // var element = DartboardElement (points: points)
        //        let outerArc = SKShapeNode()
        //        let path = UIBezierPath(arcCenter: CGPoint(x: 100, y: 200), radius: 30, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true).cgPath
        //        outerArc.path = path
        //        outerArc.fillColor = UIColor.red
        //        outerArc.strokeColor = UIColor.red
        //        gameScene?.addChild(outerArc)
        // gameScene.addChild(element.node)
    }
    
    
    func createDartboardElements () {

//        for points in pointsArray {
//            addField(points)
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
