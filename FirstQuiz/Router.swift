//
//  Router.swift
//  FirstQuiz
//
//  Created by Sergiu on 3/29/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation


public protocol Router {
    
    associatedtype Question: Hashable
    associatedtype Answer
    
    func route(to question: Question, answerCallback: @escaping (Answer) -> Void)
    func route(to result: Results<Question, Answer>)
}


