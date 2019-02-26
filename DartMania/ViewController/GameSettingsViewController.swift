//
//  GameSettingsViewController.swift
//  DartMania
//
//  Created by Tim Hehmann on 26.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController {
    
    var settings: DartGameSettings = DartGameSettings()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightText
        view.accessibilityIdentifier = "gameSettingsView"
        
        let backgroundImageView = UIImageView(image: UIImage(named: "dartboard.jpg"))
        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        self.view.addSubview(backgroundImageView)
        
        
        let modeSwitch =
            DMCustomControlsFactory.createSegmentedControl(
                items: Settings.availableModes,
                labelText: "Mode",
                withWidthInPercent: 0.7
            )
        modeSwitch.addTarget(self, action: #selector(handleModeChange(sender:)), for: .valueChanged)
        modeSwitch.selectedSegmentIndex = 1
        self.view.addSubview(modeSwitch)
        modeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modeSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.2).isActive = true
        
        let modeSwitchLabel = DMCustomControlsFactory.createLabel(withText: "Mode")
        self.view.addSubview(modeSwitchLabel)
        modeSwitchLabel.leftAnchor.constraint(equalTo: modeSwitch.leftAnchor, constant: 20).isActive = true
        modeSwitchLabel.bottomAnchor.constraint(equalTo: modeSwitch.topAnchor).isActive = true
        modeSwitchLabel.widthAnchor.constraint(equalTo: modeSwitch.widthAnchor).isActive = true
        
        
        let playerCountSwitch = DMCustomControlsFactory
            .createSegmentedControl(
                items: Settings.availablePlayerCounts,
                labelText: "# of Players",
                withWidthInPercent: 0.7
            )
        playerCountSwitch.selectedSegmentIndex = 1
        playerCountSwitch.addTarget(self, action: #selector(handlePlayerCountChange(sender:)), for: .valueChanged)
        self.view.addSubview(playerCountSwitch)
        playerCountSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerCountSwitch.topAnchor.constraint(equalTo: modeSwitch.bottomAnchor, constant: 50).isActive = true
        
        let playerCountSwitchLabel = DMCustomControlsFactory.createLabel(withText: "# of Players")
        self.view.addSubview(playerCountSwitchLabel)
        playerCountSwitchLabel.leftAnchor.constraint(equalTo: playerCountSwitch.leftAnchor, constant: 20).isActive = true
        playerCountSwitchLabel.bottomAnchor.constraint(equalTo: playerCountSwitch.topAnchor).isActive = true
        playerCountSwitchLabel.widthAnchor.constraint(equalTo: playerCountSwitch.widthAnchor).isActive = true
        
        
        
        let startLocalGameButton = DMCustomControlsFactory.createButton(withTitle: "Start local game", withWidthInPercent: 0.7)
        startLocalGameButton.addTarget(self, action: #selector(startLocalGame), for: .touchUpInside)
        self.view.addSubview(startLocalGameButton)

        startLocalGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startLocalGameButton.bottomAnchor.constraint(equalTo: view!.bottomAnchor, constant: -view!.bounds.height * 0.2).isActive = true
        
        // needs double field for finish?
        // Select Colors for darts
        // Select time to throw?

        // Do any additional setup after loading the view.
    }
    
    @objc func handleModeChange(sender: UISegmentedControl) {
        settings.setMode(points: Int(Settings.availableModes[sender.selectedSegmentIndex])!)
    }
    
    @objc func handlePlayerCountChange(sender: UISegmentedControl) {
        settings.setPlayerCount(count: Int(Settings.availablePlayerCounts[sender.selectedSegmentIndex])!)
    }
    
    @objc func startLocalGame() {
        let game = GameViewController()
        game.settings = settings
        present(game, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
