//
//  Flow.swift
//  FirstQuiz
//
//  Created by Sergiu on 1/8/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation

protocol Router { }

class Flow {
    let router: Router

    init (router: Router) {
        self.router = router
    }

    func start() {
        
    }
}

