//
//  FlowTest.swift
//  FirstQuizTests
//
//  Created by Sergiu on 1/8/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import FirstQuiz

class FlowTest: XCTestCase {
    
    func test_start_withNoQuestion_doesNotRoute() {
        
        let router = RouterSpy()
        let sut = Flow(question: [], router: router)
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_doesRouteToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1"], router: router)
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_doesRouteToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1"], router: router)
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, ["Q1"])
    }
    
    func test_start_withTwoQuestion_doesRouteToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1", "Q2"], router: router)
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, ["Q1"])
    }
    
    func test_startTwice_withOneQuestion_doesRouteToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1"], router: router)
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, ["Q1", "Q1"])
    }
    
    func test_startTwice_withTwoQuestions_doesRouteToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1", "Q2"] , router: router)
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, ["Q1", "Q1"])
        
    }
    
    func test_startAnswerFirstQuestion_withTwoQuestions_doesRouteToSecondQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1", "Q2"], router: router)
        sut.start()

        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestion, ["Q1", "Q2"])
    }
    
    func test_startAnswerFirstAndSecondQuestion_withThreeQuestion_doesRouteToThirdQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1", "Q2", "Q3"], router: router)
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestion, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAnswerFirstQuestion_withOneQuestion_doesNotRouteToOtherQuestion() {
        let router = RouterSpy()
        let sut = Flow(question: ["Q1"], router: router)
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestion, ["Q1"])
    }
    
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: [String] = []
        var answerCallback: (String) -> Void = {_ in }
        
        func route(to question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestionCount += 1
            routedQuestion.append(question)
            self.answerCallback = answerCallback
        }
    }
    
}
