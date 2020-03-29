//
//  RouterSpy.swift
//  FirstQuizTests
//
//  Created by Sergiu on 3/29/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
@testable import FirstQuiz

class RouterSpy: Router {
    var routedQuestions: [Question] = []
    var routedResults: Results<String, String>? = nil
    var answerCallback: (Answer) -> Void = {_ in }
    
    func route(to question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func route(to result: Results<String, String>) {
        routedResults = result
    }
}
