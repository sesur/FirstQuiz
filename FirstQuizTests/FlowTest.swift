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
        XCTAssertEqual(router.routedResults?.answer, [:])
    }
    
    func test_startAnswerFirstQuestion_withOneQuestion_routesToResults() {
        let sut = makeSut(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResults?.answer, ["Q1": "A1"])
    }
    
    func test_startAnswerAndSecondQuestion_withTwoQuestions_routesToResults() {
        let sut = makeSut(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults?.answer, ["Q1": "A1", "Q2": "A2"])
    }
    
    // des not route to results
    func test_start_withOneQuestion_doesNotRouteToResults() {
        makeSut(questions: ["Q1"]).start()
        XCTAssertNil(router.routedResults)
    }
    
    func test_startAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResults() {
        let sut =  makeSut(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResults)
    }
    
    //scoring
    func test_startAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
        let sut = makeSut(questions: ["Q1", "Q2"], scoring: { _ in 10})
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults?.score, 10)
    }
    
    func test_startAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithCorrectAnswers() {
        var receivedAnswer = [String: String]()
        let sut = makeSut(questions: ["Q1", "Q2"], scoring: { answers in
            receivedAnswer = answers
            return 20})
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(receivedAnswer, ["Q1": "A1", "Q2":"A2"])
    }
    
    
    
    
    
    
    
    //  MARK:- Helpers
    
    func makeSut(questions: [String], scoring: @escaping ([String: String]) -> Int = {_ in 0 }) -> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: router, scoring: scoring)
    }
}
