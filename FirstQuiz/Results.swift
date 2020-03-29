//
//  Results.swift
//  FirstQuiz
//
//  Created by Sergiu on 3/29/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation


public struct Results<Question: Hashable, Answer> {
    public let answer: [Question: Answer]
    public let score: Int
}
