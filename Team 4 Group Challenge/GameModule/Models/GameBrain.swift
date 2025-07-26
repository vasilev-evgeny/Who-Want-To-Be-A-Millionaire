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
    
     let questionsWorth = [
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
    
    var isGameOver = false //переменная чтобы чекать, закончилась ли игра
    
    var currentPrize: Int {
        return currentQuestion > 0 ? answers[15 - currentQuestion].questionPrice : 0
    }  //переменная для текущего выигрыша
    
    var guaranteedPrize: Int = 0 //переменная для несгораемой суммы
    
    var hintButtons = [
        ("50_50", true, true),
        ("audience", true, true),
        ("life", true, false)
    ]
    
    func refreshGame() {
        self.easy = easy.shuffled()
        self.medium = medium.shuffled()
        self.hard = hard.shuffled()
        currentQuestion = 0
        guaranteedPrize = 0
        hintButtons[0].1 = true
        hintButtons[1].1 = true
        hintButtons[2].1 = true
    }
    var isGameInProgress : Bool = false
    
    var allTimeRecord : Int = 0
    
    var isMistakeAvialibale : Bool = true
}
