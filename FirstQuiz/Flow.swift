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
    
    private var results: [String: String] = [:]
    
    init (questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion, answerCallback: nextCallback(question: firstQuestion))
        } else {
            router.route(to: results)
        }
    }
    
    private func nextCallback(question: String) -> (String) -> Void {
        return  { [weak self] in self?.routeNext(question, $0)
        }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        if let firstIndex = questions.firstIndex(of: question) {
            results[question] = answer
            
            let nextQuestionIndex = firstIndex + 1
            if  nextQuestionIndex < questions.count {
                let nextQuestion = questions[firstIndex+1]
                router.route(to: nextQuestion, answerCallback: nextCallback(question: nextQuestion))
            } else {
                 router.route(to: results)
            }
        }
    }
    
}
