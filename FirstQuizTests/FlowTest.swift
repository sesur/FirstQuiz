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
        
        let router = Router()
        let sut = Flow(router: router)
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
}
