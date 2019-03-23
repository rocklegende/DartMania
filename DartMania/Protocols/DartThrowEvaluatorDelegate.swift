//
//  DartThrowEvaluatorDelegate.swift
//  DartMania
//
//  Created by Tim Hehmann on 23.03.19.
//  Copyright © 2019 Tim Hehmann. All rights reserved.
//

import Foundation

protocol DartThrowEvaluatorDelegate: class {
    func didEvaluateThrow(hitPoints: Int)
}
