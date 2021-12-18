//
//  DMGame.swift
//  DartMania
//
//  Created by Tim Hehmann on 21.02.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import Foundation

class DMGame: NSObject {
    
    private var pointsMadeInCurrentThrow: Int = 0
    
    @objc dynamic var isOver: Bool = false
    @objc dynamic var players: [[String : Any]] = []
    var throwsLeft: Int = 3
    var currentPlayer: Int = 0
    var settings: DartGameSettings
    
    init(settings: DartGameSettings) {
        self.settings = settings
        super.init()
        initPlayers()
    }
    
    private func initPlayers() {
        let numberOfPlayers = settings.getPlayerCount()
        for _ in 0..<numberOfPlayers {
            players.append(["points": settings.getMode(), "isActive": false])
        }
        setPlayerActive(withNumber: 0)
    }
    
    private func updateValueForAllPlayers(value: Any, key: String) {
        let numberOfPlayers = settings.getPlayerCount()
        for i in 0..<numberOfPlayers {
            players[i].updateValue(value, forKey: key)
        }
        
        didChangeState()
    }
    
    private func setPlayerActive(withNumber number: Int) {
        updateValueForAllPlayers(value: false, key: "isActive")
        players[number].updateValue(true, forKey: "isActive")
        
        didChangeState()
    }
    
    func stop() {
        isOver = true
    }
     
    func restart() {
        isOver = false
        updateValueForAllPlayers(value: settings.getMode(), key: "points")
        setPlayerActive(withNumber: 0)
    }
     
    func updatePoints (hitPoints: Int) {
        decreaseThrowsLeft()
        if let pointsLeft = players[currentPlayer]["points"] as? Int {
            if (pointsLeft - hitPoints > 0) {
                players[currentPlayer].updateValue(pointsLeft - hitPoints, forKey: "points")
            } else if (pointsLeft - hitPoints == 0) {
                // TODO: check if double
                players[currentPlayer].updateValue(pointsLeft - hitPoints, forKey: "points")
                isOver = true
            } else {
                switchToNextPlayer()
            }
        }
        
        if (throwsLeft == 0) {
            switchToNextPlayer()
        }
        
        didChangeState()
    }
    
    func didChangeState() {
        NotificationCenter.default.post(name: Notification.Name("didChangeState"), object: nil)
    }
    
    func isFinished() -> Bool {
        return isOver
    }
     
    func switchToNextPlayer() {
        resetThrowsLeft()
        resetPointsMadeInCurrentThrow()
        players[currentPlayer].updateValue(false, forKey: "isActive")
        increaseCurrentPlayer()
        players[currentPlayer].updateValue(true, forKey: "isActive")
        
        NotificationCenter.default.post(name: Notification.Name("didSwitchPlayer"), object: nil)
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
    }
    
    func resetThrowsLeft() {
        self.throwsLeft = 3
    }
    
    func getThrowsLeft() -> Int {
        return self.throwsLeft
    }
    
    func stateAsString() -> String {
        var stateString = ""
        for i in 0..<players.count {
            stateString += "Player \(i + 1): \(players[i]["points"] as! Int)"
            if (players[i]["isActive"] as! Bool) {
                stateString += " -> current turn"
            }
            stateString += "\n"
        }
        
        return stateString
    }
}
