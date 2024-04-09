import Foundation

public protocol Router {
    
    associatedtype Question: Hashable
    associatedtype Answer
    
    func route(to question: Question, answerCallback: @escaping (Answer) -> Void)
    func route(to result: Results<Question, Answer>)
}
