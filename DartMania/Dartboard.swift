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
    var elements: [DartboardElement]
    
    init(gameScene: SKScene) {
        self.gameScene = gameScene
        self.elements = []
        // createSingleArc()
        createDartboardElements()
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
        var points = 0
        for element in elements {
            if (element.node.path?.contains(point))! {
                points = element.points
            }
        }
        return points
 
    }
    
    func addField (points: Int, position: Int) {
        // 360 / 20 = 18 --> ein Feld hat 18 Grad
        // Wichtig: versetzt um 9 Grad am anfang! also z.B. das 1er Feld: 9 Grad - 27 Grad
        
        let offset = Double.pi / Double(Settings.pointsArray.count)
        let trippleColor = position % 2 == 0 ? UIColor.black : UIColor.green
        let singleColor = position % 2 == 0 ? UIColor.red : UIColor.white
        
        let startingAngle = CGFloat(offset) + (CGFloat(position) / CGFloat(Settings.pointsArray.count)) * (2 * CGFloat.pi)
        let endAngle = CGFloat(offset) + (CGFloat(position + 1) / CGFloat(Settings.pointsArray.count)) * (2 * CGFloat.pi)
        
        print("")
        print(startingAngle)
        print(endAngle)
        
        addSingleField(points: 2 * points, radius: 220, startAngle: startingAngle, endAngle: endAngle, color: trippleColor)
        
        addSingleField(points: 0, radius: 203, startAngle: startingAngle, endAngle: endAngle, color: UIColor.gray)
        
        addSingleField(points: points, radius: 200, startAngle: startingAngle, endAngle: endAngle, color: singleColor)
        
        addSingleField(points: 0, radius: 143, startAngle: startingAngle, endAngle: endAngle, color: UIColor.gray)
        
        addSingleField(points: 3 * points, radius: 140, startAngle: startingAngle, endAngle: endAngle, color: trippleColor)
        
        addSingleField(points: 0, radius: 123, startAngle: startingAngle, endAngle: endAngle, color: UIColor.gray)
        
        addSingleField(points: points, radius: 120, startAngle: startingAngle, endAngle: endAngle, color: singleColor)
        
        
        // - according to that position get the right starting and end angles for the arc
        // - create 2x field
        // - create outer 1x field
        // - create 3x field
        // - create inner 1x field
        // - create edges between every field
        // - add label
        // if bullseye create dots..
    }
    
    func addSingleField (points: Int, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, color: UIColor) {
        
        // TODO: wirklich nur ringsegment erstellen mit 2 arc paths und 2 linien
        
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 200), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: 200))
        let field = DartboardElement(points: points, path: path, color: color)
        gameScene?.addChild(field.node)
        self.elements.append(field)
        // gameScene.addChild(element.node)
    }
    
    
    func createDartboardElements () {
        for i in 0..<Settings.pointsArray.count {
            addField(points: Settings.pointsArray[i], position: i)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
