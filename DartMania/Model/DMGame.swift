//
//  DMGame.swift
//  DartMania
//
//  Created by Tim Hehmann on 21.02.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import Foundation

class DMGame: NSObject {
     
    private var throwsLeft: Int = 3
    private var pointsMadeInCurrentThrow: Int = 0
    @objc dynamic var finished: Bool = false
    @objc dynamic var players: [[String : Any]] = []
    var currentPlayer: Int = 0
    var settings: DartGameSettings
    
    init(settings: DartGameSettings) {
        self.settings = settings
        super.init()
        initPlayers()
    }
    
    private func setPlayerActive(withNumber number: Int) {
        let numberOfPlayers = settings.getPlayerCount()
        for i in 0..<numberOfPlayers {
            players[i].updateValue(false, forKey: "isActive")
        }
        players[number].updateValue(true, forKey: "isActive")
    }
    
    private func initPlayers() {
        let numberOfPlayers = settings.getPlayerCount()
        for _ in 0..<numberOfPlayers {
            players.append(["points": settings.getMode(), "isActive": false])
        }
        setPlayerActive(withNumber: 0)
    }
     
     
    func state() {
        
    }
     
    func start() {
        
    }
     
    func stop() {
        finished = true
    }
     
    func restart() {
        
    }
     
    func updatePoints (hitPoints: Int) {
        if let pointsLeft = players[currentPlayer]["points"] as? Int {
            if (pointsMadeInCurrentThrow + hitPoints < pointsLeft) {
                pointsMadeInCurrentThrow += hitPoints
                players[currentPlayer].updateValue(pointsLeft - hitPoints, forKey: "points")
            } else if (pointsMadeInCurrentThrow + hitPoints == pointsLeft) {
                // TODO: check if double
                players[currentPlayer].updateValue(pointsLeft - hitPoints, forKey: "points")
                finished = true
            } else {
                switchToNextPlayer()
            }
        }
        
    }
     
    func addPlayer() {
        
    }
     
    func removePlayer() {
        
    }
     
    func isFinished() -> Bool {
        return finished
    }
     
    func switchToNextPlayer() {
        players[currentPlayer].updateValue(false, forKey: "isActive")
        increaseCurrentPlayer()
        players[currentPlayer].updateValue(true, forKey: "isActive")
        
        resetThrowsLeft()
        resetPointsMadeInCurrentThrow()
    }
     
    func resetPointsMadeInCurrentThrow() {
        pointsMadeInCurrentThrow = 0
    }
     
    func increaseCurrentPlayer() {
        currentPlayer += 1
        if currentPlayer == settings.getPlayerCount() {
            currentPlayer = 0
        }
    }
    
    func decreaseThrowsLeft() {
        throwsLeft -= 1
        if (throwsLeft == 0) {
            switchToNextPlayer()
        }
    }
    
    func resetThrowsLeft() {
        self.throwsLeft = 3
    }
}
