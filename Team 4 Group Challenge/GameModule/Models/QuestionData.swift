//
//  QuestionData.swift
//  Team 4 Group Challenge
//
//  Created by Mariia on 24.07.2025.
//

struct APIResponse: Decodable {
    let response_code: Int
    let results: [QuestionData]
}

struct QuestionData: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

