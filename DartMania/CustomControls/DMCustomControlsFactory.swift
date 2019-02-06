//
//  DMButtonFactory.swift
//  DartMania
//
//  Created by Tim Hehmann on 04.02.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import UIKit

class DMCustomControlsFactory {
    
    static private var cornerRadius: CGFloat = 25.0
    static private var borderWidth: CGFloat = 3.0
    static private var borderColor = UIColor.white.cgColor
    static private var clipsToBounds = true
    static private var titleColor = UIColor.white
    static private var translatesAutoresizingMaskIntoConstraints = false
    static private var font = UIFont(name: "Superclarendon-BlackItalic" , size: 18)
    static private var buttonHeight: CGFloat = 50
    static private var labelHeight: CGFloat = 30
    
    static func createButton(withTitle title: String, withWidthInPercent width: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byClipping
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = Settings.dartBoardRed
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor
        button.clipsToBounds = true
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * width).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func createSegmentedControl(items: [Any], labelText: String, withWidthInPercent width: CGFloat) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: font!], for: .normal)
        segmentedControl.tintColor = titleColor
        segmentedControl.backgroundColor = Settings.dartBoardGreen
        segmentedControl.layer.cornerRadius = cornerRadius
        segmentedControl.layer.borderWidth = borderWidth
        segmentedControl.layer.borderColor = borderColor
        segmentedControl.clipsToBounds = true
        segmentedControl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * width).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
//        let label = createLabel(withText: labelText)
//        
//        segmentedControl.addSubview(label)
//        label.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -10).isActive = true
//        label.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
//        print(label.frame)
//        print(segmentedControl.frame)
        return segmentedControl
    }
    
    static func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.font = font
        label.textColor = titleColor
        label.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        label.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        return label
    }
}
