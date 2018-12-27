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
        mode = points
    }
    
    func setPlayerCount(count: Int) {
        playerCount = count
    }
    
    func getMode() -> Int {
        return mode
    }
    
    func getPlayerCount() -> Int{
        return playerCount
    }

}
