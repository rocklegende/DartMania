//
//  DartGameSettings.swift
//  DartMania
//
//  Created by Tim Hehmann on 26.12.18.
//  Copyright © 2018 Tim Hehmann. All rights reserved.
//

import UIKit

class DartGameSettings {
    
    private var mode: Int = 501
    private var playerCount: Int = 2
    private var needsDoubleFieldForFinish: Bool = true
    
    init() {
    }
    
    func setMode(points: Int) {
        let modeIsAvailable = Settings.availableModes.contains("\(points)")
        
        if (modeIsAvailable) {
            mode = points
        } else {
            print("You tried to set the mode to unavailable mode \(points). Defaulting to 501 Points for this Game.")
            mode = 501
        }
    }
    
    func setNumberOfPlayers(_ number: Int) {
        let numberOfPlayersIsAvailable = Settings.availablePlayerCounts.contains("\(number)")
        
        if (numberOfPlayersIsAvailable) {
            playerCount = number
        } else {
            print("You tried to set the number of players to unavailable number \(number). Defaulting to 2 Player for this Game.")
            playerCount = 2
        }
    }
    
    func getMode() -> Int {
        return mode
    }
    
    func getPlayerCount() -> Int{
        return playerCount
    }

}
