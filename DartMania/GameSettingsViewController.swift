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
        view.backgroundColor = Settings.dartBoardWhite
        
//        let modeSwitch = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
//        modeSwitch.isOn = true
//        modeSwitch.setOn(true, animated: true)
//        self.view.addSubview(modeSwitch)
        //modeSwitch.addTarget(self, action: #selector(handleModeChange(mode: modeSwitch.isOn)), for: .valueChanged)
        
        let modeSwitch = UISegmentedControl(items: Settings.availableModes)
        modeSwitch.addTarget(self, action: #selector(handleModeChange(sender:)), for: .valueChanged)
        modeSwitch.center = self.view.center
        modeSwitch.selectedSegmentIndex = 1
        
        modeSwitch.layer.cornerRadius = 5.0
        modeSwitch.backgroundColor = .white
        modeSwitch.tintColor = .blue
        self.view.addSubview(modeSwitch)
        
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        modeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modeSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        modeSwitch.widthAnchor.constraint(equalToConstant: 200).isActive = true
        modeSwitch.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        
        let playerCountSwitch = UISegmentedControl(items: Settings.availablePlayerCounts)
        playerCountSwitch.addTarget(self, action: #selector(handlePlayerCountChange(sender:)), for: .valueChanged)
        playerCountSwitch.selectedSegmentIndex = 1
        
        playerCountSwitch.layer.cornerRadius = 5.0
        playerCountSwitch.backgroundColor = .white
        playerCountSwitch.tintColor = .blue
        self.view.addSubview(playerCountSwitch)
        
        playerCountSwitch.translatesAutoresizingMaskIntoConstraints = false
        playerCountSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerCountSwitch.topAnchor.constraint(equalTo: modeSwitch.bottomAnchor, constant: 50).isActive = true
        playerCountSwitch.widthAnchor.constraint(equalTo: modeSwitch.widthAnchor).isActive = true
        playerCountSwitch.heightAnchor.constraint(equalTo: modeSwitch.heightAnchor).isActive = true
        
        
        
        let startLocalGameButton = UIButton(type: .system)
        startLocalGameButton.setTitle("Start local game", for: .normal)
        startLocalGameButton.addTarget(self, action: #selector(startLocalGame), for: .touchUpInside)
        startLocalGameButton.backgroundColor = .white
        self.view.addSubview(startLocalGameButton)
        
        startLocalGameButton.translatesAutoresizingMaskIntoConstraints = false
        startLocalGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startLocalGameButton.topAnchor.constraint(equalTo: playerCountSwitch.bottomAnchor, constant: 50).isActive = true
        startLocalGameButton.widthAnchor.constraint(equalTo: modeSwitch.widthAnchor).isActive = true
        startLocalGameButton.heightAnchor.constraint(equalTo: modeSwitch.heightAnchor).isActive = true
        
        
        
        // 1 - 4 player
        // 301 or 501?
        // needs double field for finish?
        // Select Colors for darts
        // Select time to throw?
        
        // Start localgame
        // pass settings object to GameViewController

        // Do any additional setup after loading the view.
    }
    
    @objc func handleModeChange(sender: UISegmentedControl) {
        settings.setMode(points: Int(Settings.availableModes[sender.selectedSegmentIndex])!)
    }
    
    @objc func handlePlayerCountChange(sender: UISegmentedControl) {
        settings.setPlayerCount(count: Int(Settings.availablePlayerCounts[sender.selectedSegmentIndex])!)
    }
    
    @objc func startLocalGame() {
        print("segue to game")
        
        let game = GameViewController()
        
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
