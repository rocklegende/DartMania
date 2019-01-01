//
//  DashboardViewController.swift
//  DartMania
//
//  Created by Tim Hehmann on 30.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        let startGameButton = UIButton(type: .system)
        startGameButton.setTitle("Start a game!", for: .normal)
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        startGameButton.backgroundColor = .white
        self.view.addSubview(startGameButton)
        
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startGameButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
        
        
        let joinGameButton = UIButton(type: .system)
        joinGameButton.setTitle("Join game", for: .normal)
        joinGameButton.addTarget(self, action: #selector(joinGame), for: .touchUpInside)
        joinGameButton.backgroundColor = .white
        self.view.addSubview(joinGameButton)
        
        joinGameButton.translatesAutoresizingMaskIntoConstraints = false
        joinGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        joinGameButton.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 100).isActive = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func joinGame() {
        // present gamecenter match picker..
    }
    
    @objc func startGame() {
        let settingsViewController = GameSettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}
