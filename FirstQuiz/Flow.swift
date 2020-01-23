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
    func route(to result: [String: String])
}

class Flow {
    private let router: Router
    private let questions: [String]
    
    init (questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion, answerCallback: routeToNext(question: firstQuestion))
        } else {
            router.route(to: [:])
        }
    }
    
    private func routeToNext(question: String) -> (String) -> Void {
        return  { [weak self] _ in
            guard let strongSelf = self else { return }
            
            if let firstIndex = strongSelf.questions.firstIndex(of: question) {
                if firstIndex+1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[firstIndex+1]
                    strongSelf.router.route(to: nextQuestion, answerCallback: strongSelf.routeToNext(question: nextQuestion))
                } else {
                    strongSelf.router.route(to: ["Q1":"A1"])
                }
            }
        }
    }
    
    
}
