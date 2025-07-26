//
//  Questions.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 21.07.2025.
//
import UIKit

final class GameBrain {
    
    static let shared = GameBrain()
    
    var easy: [Question] = []
    
    var medium: [Question] = []
    
    var hard: [Question] = []
    
    private let questionsWorth = [
        500,
        1000,
        2000,
        3000,
        5000,
        7500,
        10000,
        12000,
        15000,
        25000,
        50000,
        100000,
        250000,
        500000,
        1000000
    ]
    
    private var newGameQuestion : [Question] {
        return easy + medium + hard
    }
    
    var sharedGameQuestions : [Question] {
        return newGameQuestion
    }
    var answers = Answer.getAnswerList()
    var currentQuestion = 0 // номер текущего вопроса, +1 к нему делаем когда кнопку НАЗАД нажимает на AnswerVC,его же можно привязать к indexPath в UITableViewCell, чтобы красить нужную по порядковому номеру ячейку
    
//    var isAnswerCorrect = true // переменная чтобы проверять правильно ли ответил юзер или нет
    
    var isGameOver = false //переменная чтобы чекать, закончилась ли игра
    
    var currentPrize: Int {
        return questionsWorth[currentQuestion]
    }  //переменная для текущего выигрыша
    
    var guaranteedPrize: Int = 0 //переменная для несгораемой суммы
    
    var isWalkAwayAvailable: Bool = true //переменная проверить, можно ли забрать деньги досрочно
    //TODO: - удалить если не нужны т.к. есть hintButtons
    var helpButtonIsEnabled = true //cостояние кнопок подсказок
    var audienceButtonIsEnabled = true //cостояние кнопок подсказок
    var mistakeButtonIsEnabled = true //cостояние кнопок подсказок
    
    var hintButtons = [
        ("50_50", true),
        ("audience", true),
        ("call", true)
    ]
    
    func refreshGame() {
        self.easy = easy.shuffled()
        self.medium = medium.shuffled()
        self.hard = hard.shuffled()
        currentQuestion = 0
        guaranteedPrize = 0
        helpButtonIsEnabled = true
        audienceButtonIsEnabled = true
        mistakeButtonIsEnabled = true
    }
//    func createQuestionArray() {
//        if newGameQuestion.isEmpty {
//            easy.shuffle()
//            medium.shuffle()
//            hard.shuffle()
//            newGameQuestion.append(contentsOf: easy)
//            newGameQuestion.append(contentsOf: medium)
//            newGameQuestion.append(contentsOf: hard)
//        }
//    }
    var isGameInProgress : Bool = false
    
    var allTimeRecord : Int = 0
}
