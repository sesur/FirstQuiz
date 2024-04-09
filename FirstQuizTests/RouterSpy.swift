import Foundation
@testable import FirstQuiz

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResults: Results<String, String>? = nil
    var answerCallback: (String) -> Void = {_ in }
    
    func route(to question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func route(to result: Results<String, String>) {
        routedResults = result
    }
}
