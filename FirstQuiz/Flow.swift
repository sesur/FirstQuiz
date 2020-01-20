//
//  Flow.swift
//  FirstQuiz
//
//  Created by Sergiu on 1/8/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation

protocol Router {
    func route(to question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let router: Router
    let questions: [String]

    init (question: [String], router: Router) {
        self.router = router
        self.questions = question
    }

    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion) {[weak self] _ in
                guard let strongSelf = self else { return }
                let firstIndex = strongSelf.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstIndex+1]
                strongSelf.router.route(to: nextQuestion) {_ in }
            }
        }
       
    }
}

