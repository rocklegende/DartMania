//
//  DashboardViewController.swift
//  DartMania
//
//  Created by Tim Hehmann on 30.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit
import GameKit

class DashboardViewController: UICollectionViewController, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    var games: [DMGame] = [DMGame(settings: DartGameSettings())]
    let customCellID = "dartGameCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.accessibilityIdentifier = "dashboardView"
        collectionView?.register(DartGameCell.self, forCellWithReuseIdentifier: customCellID)
        print(games)
        
        addNavBarImage()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startGame))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellID, for: indexPath) as! DartGameCell
        cell.game = games[indexPath.item]
        cell.gameStateLabel.text = cell.game?.stateAsString()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DartGameCell
        let gameVC = GameViewController()
        gameVC.game = cell.game
        self.navigationController?.pushViewController(gameVC, animated: true)
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
        collectionView?.reloadData()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}

class DartGameCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var game: DMGame?
    
    let gameStateLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "blablab"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        addSubview(gameStateLabel)
        backgroundColor = UIColor.white
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": gameStateLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": gameStateLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
