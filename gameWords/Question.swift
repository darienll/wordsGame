//
//  Question.swift
//  gameWords
//
//  Created by Daryn on 5/19/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation

class Question {
    var title: String?
    var answers : [String] = []
    var scores : [Int] = []
    init(title: String, answers : [String], scores : [Int]) {
        self.title = title
        self.answers = answers
        self.scores = scores
    }
}
