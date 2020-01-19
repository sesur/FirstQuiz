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
    
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        
        func route(to question: String) {
            routedQuestionCount += 1
        }
    }
    
}
