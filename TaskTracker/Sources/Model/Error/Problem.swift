//
//  Problem.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 17/07/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

struct Problem: Error {
    let message: String
    let code: Int
    let isNetworkProblem: Bool
    
    init(message: String = "unknown_error", code: Int = -1, isNetworkProblem: Bool = false) {
        self.message = message
        self.code = code
        self.isNetworkProblem = isNetworkProblem
    }
}
