//
//  DashboardViewController.swift
//  DartMania
//
//  Created by Tim Hehmann on 30.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import GameKit

class DashboardViewController: UIViewController, UINavigationControllerDelegate {
    
    var games: [DMGame] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        view.accessibilityIdentifier = "dashboardView"
        print(games)
        
        addNavBarImage()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startGame))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(games)
    }
    
    func addNavBarImage() {
        
        let navController = navigationController!
        let fullTextLogoImage = UIImage(named: "DMFullTextLogo")
        let imageView = UIImageView(image: fullTextLogoImage)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 3 - fullTextLogoImage!.size.width / 3
        let bannerY = bannerHeight / 3 - fullTextLogoImage!.size.height / 3
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }

    @objc func joinGame() {
        // present gamecenter match picker..
    }
    
    @objc func startGame() {
        let settingsViewController = GameSettingsViewController()
        settingsViewController.gameSettingsSelectionDelegate = self
        present(settingsViewController, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func addBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "dartboard.jpg"))
        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        self.view.addSubview(backgroundImageView)
    }
    
}

extension DashboardViewController : GameSettingsSelectionDelegate {
    func didPickGameSettings(settings: DartGameSettings) {
        let gameVC = GameViewController()
        gameVC.game = DMGame(settings: settings)
        games.append(gameVC.game)
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
