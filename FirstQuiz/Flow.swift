//
//  Flow.swift
//  FirstQuiz
//
//  Created by Sergiu on 1/8/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation

protocol Router {
    func route(to question: String)
}

class Flow {
    let router: Router
    let questions: [String]

    init (question: [String], router: Router) {
        self.router = router
        self.questions = question
    }

    func start() {
        if !questions.isEmpty {
            router.route(to: "Q1")
        }
       
    }
}

