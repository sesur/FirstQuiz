//
//  GameTests.swift
//  FirstQuizTests
//
//  Created by Sergiu on 3/29/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import XCTest
import FirstQuiz

class GameTests: XCTestCase {
    
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answeringZeroOfTwoQuestion_scoresZero() {
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        XCTAssertEqual(router.routedResults?.score, 0)
    }
    
    func test_startGame_answeringOneOfTwoQuestion_scoresOne() {
        router.answerCallback("A1")
        router.answerCallback("wrong")
        XCTAssertEqual(router.routedResults?.score, 1)
    }
    
    func test_startGame_answeringTwoOfTwoQuestion_scoresTwo() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults?.score, 2)
    }
}
