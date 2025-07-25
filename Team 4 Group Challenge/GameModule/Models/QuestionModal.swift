//
//  QuestionModal.swift
//  Team 4 Group Challenge
//
//  Created by Mariia on 25.07.2025.
//


struct QuestionModal: Decodable {
    let question: String
    let answers: [String]
    let correctAnswer: String
}
