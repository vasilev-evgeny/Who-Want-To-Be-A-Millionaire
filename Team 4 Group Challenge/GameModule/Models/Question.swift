//
//  Question.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 21.07.2025.
//
import Foundation
import UIKit

struct Question {
    let question: String
    let answers: [String]
    let correctAnswer: String
    
    init(question: String, answers: [String], correctAnswer: String) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
}
