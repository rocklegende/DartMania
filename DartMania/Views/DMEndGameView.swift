//
//  DMEndGameView.swift
//  DartMania
//
//  Created by Tim Hehmann on 03.03.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import UIKit

protocol EndGameDecisionDelegate : class {
    func didTapReturnToMenuButton()
}

class DMEndGameView: UIView {
    
    weak var endGameDecisionDelegate: EndGameDecisionDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addReplayButton()
        addGoBackToMenuButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addReplayButton() {
        let button = DMCustomControlsFactory.createButton(withTitle: "Play again", withWidthInPercent: 0.4)
        addSubview(button)
        button.rightAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bounds.height * 0.2).isActive = true
        button.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        
    }
    
    func addWinnerMessage() {
        let label = DMCustomControlsFactory.createLabel(withText: "Player X won!")
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.4).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func addGoBackToMenuButton() {
        let button = DMCustomControlsFactory.createButton(withTitle: "Go back", withWidthInPercent: 0.4)
        addSubview(button)
        button.leftAnchor.constraint(equalTo: centerXAnchor, constant: 5).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bounds.height * 0.2).isActive = true
        button.addTarget(self, action: #selector(goBackToMenu), for: .touchUpInside)
    }
    
    @objc func restartGame() {
//        unblurScreen()
//        game.restart()
        print("restart pressed")
    }
    
    @objc func goBackToMenu() {
//        self.removeFromParent()
//        self.view?.presentScene(nil)
        endGameDecisionDelegate.didTapReturnToMenuButton()
        print("go back button was pressed")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
