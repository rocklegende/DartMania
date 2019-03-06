//
//  EndGameDecisionDelegate.swift
//  DartMania
//
//  Created by Tim Hehmann on 04.03.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import Foundation

protocol EndGameDecisionDelegate : class {
    func didTapReturnToMenuButton()
    func didTapRestartButton()
}
