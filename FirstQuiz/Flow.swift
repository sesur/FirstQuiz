import Foundation

class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let router: R
    private let questions: [Question]
    private var results: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init (questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.router = router
        self.questions = questions
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion, answerCallback: nextCallback(question: firstQuestion))
        } else {
            router.route(to: result())
        }
    }
    
    private func nextCallback(question: Question) -> (Answer) -> Void {
        return  { [weak self] in self?.routeNext(question, $0)
        }
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        if let firstIndex = questions.firstIndex(of: question) {
            results[question] = answer
            
            let nextQuestionIndex = firstIndex + 1
            if  nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.route(to: nextQuestion, answerCallback: nextCallback(question: nextQuestion))
            } else {
                router.route(to:result())
            }
        }
    }
    
    private func result() -> Results<Question, Answer> {
        return Results(answer: results, score: scoring(results))
    }
}
