import Foundation

public struct Results<Question: Hashable, Answer> {
    public let answer: [Question: Answer]
    public let score: Int
}
