//
//  Questions.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 21.07.2025.
//
import UIKit

final class GameBrain {
    
    static let shared = GameBrain()
    
    var easy: [Question] = [
        Question(
            question: "Какой город называют 'Городом любви'?",
            answers: ["Венеция", "Прага", "Париж", "Рим"],
            correctAnswer: "Париж"
        ),
        Question(
            question: "Где находится статуя Христа-Искупителя?",
            answers: ["Буэнос-Айрес", "Рио-де-Жанейро", "Лима", "Сантьяго"],
            correctAnswer: "Рио-де-Жанейро"
        ),
        Question(
            question: "В каком городе находится Колизей?",
            answers: ["Афины", "Стамбул", "Рим", "Каир"],
            correctAnswer: "Рим"
        ),
        Question(
            question: "Какой город построен на 118 островах?",
            answers: ["Амстердам", "Стокгольм", "Венеция", "Копенгаген"],
            correctAnswer: "Венеция"
        ),
        Question(
            question: "Где находится Сиднейский оперный театр?",
            answers: ["Мельбурн", "Окленд", "Сидней", "Брисбен"],
            correctAnswer: "Сидней"
        )
    ]
    
    var medium: [Question] = [
        Question(
            question: "Какой город называют 'Большим яблоком'?",
            answers: ["Чикаго", "Лос-Анджелес", "Нью-Йорк", "Торонто"],
            correctAnswer: "Нью-Йорк"
        ),
        Question(
            question: "Где находится древний город Петра?",
            answers: ["Египет", "Иордания", "Сирия", "Ирак"],
            correctAnswer: "Иордания"
        ),
        Question(
            question: "Какой город является самым густонаселённым в мире?",
            answers: ["Дели", "Шанхай", "Токио", "Сан-Паулу"],
            correctAnswer: "Токио"
        ),
        Question(
            question: "Где находится район Небесных мостов?",
            answers: ["Сингапур", "Куала-Лумпур", "Дубай", "Гонконг"],
            correctAnswer: "Сингапур"
        ),
        Question(
            question: "Какой город называют 'Городом ветров'?",
            answers: ["Чикаго", "Бостон", "Торонто", "Детройт"],
            correctAnswer: "Чикаго"
        )
    ]
    
    var hard: [Question] = [
        Question(
            question: "Какой город является самым северным миллионником?",
            answers: ["Осло", "Хельсинки", "Санкт-Петербург", "Стокгольм"],
            correctAnswer: "Санкт-Петербург"
        ),
        Question(
            question: "Где находится самая узкая улица (31 см)?",
            answers: ["Прага", "Ротенбург-на-Таубере", "Венеция", "Амстердам"],
            correctAnswer: "Ротенбург-на-Таубере"
        ),
        Question(
            question: "Какой город построен на месте древнего озера?",
            answers: ["Мехико", "Каир", "Дели", "Бангкок"],
            correctAnswer: "Мехико"
        ),
        Question(
            question: "Где находится самый длинный морской мост?",
            answers: ["Китай", "Япония", "США", "ОАЭ"],
            correctAnswer: "Китай"
        ),
        Question(
            question: "Какой город имеет форму самолёта при виде сверху?",
            answers: ["Бразилиа", "Канберра", "Астана", "Исламабад"],
            correctAnswer: "Бразилиа"
        )
    ]
    
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
    
//    var isAnswerCorrect = true // переменная чтобы проверять правильно ли ответил юзер или нет
    
    var isGameOver = false //переменная чтобы чекать, закончилась ли игра
    
    var currentPrize: Int {
        return currentQuestion > 0 ? answers[15 - currentQuestion].questionPrice : 0
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
