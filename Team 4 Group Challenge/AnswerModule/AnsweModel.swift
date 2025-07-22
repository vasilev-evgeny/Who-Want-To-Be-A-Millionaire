//
//  AnsweModel.swift
//  Team 4 Group Challenge
//
//  Created by Andrei Kovryzhenko on 22.07.2025.
//

import Foundation

enum AnswerType {
    case regular
    case safe
    case top
}

struct Answer {
    let questionNumber: Int
    let questionPrice: String
    let type: AnswerType
    var isCurrent: Bool
}

extension Answer {
    static func getAnswerList() -> [Answer] {
        return [
            Answer(questionNumber: 15, questionPrice: "1,000,000", type: .top, isCurrent: false),
            Answer(questionNumber: 14, questionPrice: "500,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 13, questionPrice: "250,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 12, questionPrice: "100,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 11, questionPrice: "50,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 10, questionPrice: "25,000", type: .safe, isCurrent: false),
            Answer(questionNumber: 9, questionPrice: "15,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 8, questionPrice: "12,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 7, questionPrice: "10,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 6, questionPrice: "7,500", type: .regular, isCurrent: false),
            Answer(questionNumber: 5, questionPrice: "5,000", type: .safe, isCurrent: false),
            Answer(questionNumber: 4, questionPrice: "3,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 3, questionPrice: "2,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 2, questionPrice: "1,000", type: .regular, isCurrent: false),
            Answer(questionNumber: 1, questionPrice: "500", type: .regular, isCurrent: true),
            
        ]
    }
}
