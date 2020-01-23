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
    
     let router = RouterSpy()
    
    func test_start_withNoQuestion_doesNotRoute() {
        let sut = makeSut(questions: [])
        sut.start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_doesRouteToCorrectQuestion() {
        let sut = makeSut(questions: ["Q1"])
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestion_doesRouteToFirstQuestion() {
        let sut = makeSut(questions: ["Q1", "Q2"])
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withOneQuestion_doesRouteToFirstQuestion() {
        let sut = makeSut(questions: ["Q1"])
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startTwice_withTwoQuestions_doesRouteToFirstQuestion() {
        let sut = makeSut(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAnswerFirstQuestion_withTwoQuestions_doesRouteToSecondQuestion() {
        let sut = makeSut(questions: ["Q1", "Q2"])
        sut.start()

        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_startAnswerFirstAndSecondQuestion_withThreeQuestion_doesRouteToThirdQuestion() {
        let sut = makeSut(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAnswerFirstQuestion_withOneQuestion_doesNotRouteToOtherQuestion() {
        let sut = makeSut(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestion_routeToResults() {
        let sut = makeSut(questions: [])
        sut.start()
        XCTAssertEqual(router.routedResults, [:])
    }
    
    func test_start_withOneQuestion_routesToResults() {
        let sut = makeSut(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResults, ["Q1": "A1"])
    }
    
    
    
    
    
    //  MARK:- Helpers

    func makeSut(questions: [String]) -> Flow {
        return Flow(questions: questions, router: router)
    }
    
    
    class RouterSpy: Router {
//        var routedQuestionCount: Int = 0
        var routedQuestions: [String] = []
        var answerCallback: (String) -> Void = {_ in }
        var routedResults: [String: String]? = nil
        
        func route(to question: String, answerCallback: @escaping (String) -> Void) {
//            routedQuestionCount += 1
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func route(to result: [String : String]) {
            routedResults = result
        }
    }
    
}
