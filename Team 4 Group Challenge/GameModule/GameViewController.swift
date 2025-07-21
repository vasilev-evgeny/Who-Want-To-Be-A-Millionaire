//
//  Untitled.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 20.07.2025.
//

import UIKit

class GameViewController: UIViewController {

    //MARK: - Create UI
    
    let backgroundImage = UIImageView(image: UIImage(named: "backGround"))
    
    //MARK: - NavigationBar
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = .clear
        return navigationBar
    }()
    
    let backButton : UIButton = {
        let backButton = UIButton()
        backButton.backgroundColor = .clear
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    let labelStack : UIStackView = {
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.spacing = 0
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        return labelStack
    }()
    
    let topTitleLabel : UILabel = {
        let topTitleLabel = UILabel()
        topTitleLabel.text = "Question #"
        topTitleLabel.textColor = .white
        topTitleLabel.font = UIFont.systemFont(ofSize: 18)
        topTitleLabel.alpha = 0.5
        topTitleLabel.textAlignment = .center
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return topTitleLabel
    }()
    
    let bottomTitleLabel : UILabel = {
        let bottomTitleLabel = UILabel()
        bottomTitleLabel.text = "$"
        bottomTitleLabel.textColor = .white
        bottomTitleLabel.font = UIFont.systemFont(ofSize: 19)
        bottomTitleLabel.textAlignment = .center
        bottomTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return bottomTitleLabel
    }()
    
    let chartButton : UIButton = {
        let chartButton = UIButton()
        chartButton.backgroundColor = .clear
        chartButton.setImage(UIImage(named: "bar_chart"), for: .normal)
        chartButton.translatesAutoresizingMaskIntoConstraints = false
        return chartButton
    }()
    
    //MARK: - Timer
    
    let timerView : UIView = {
        let timerView = UIView()
        timerView.layer.cornerRadius = 50
        timerView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        timerView.translatesAutoresizingMaskIntoConstraints = false
        return timerView
    }()
    
    let timerImage = UIImageView(image: UIImage(named: "stopwatch"))
    
    let timerCounter : UILabel = {
        let timerCounter = UILabel()
        timerCounter.text = "60"
        timerCounter.font = UIFont(name: "SFCompactDisplay-Semibold", size: 24)
        timerCounter.translatesAutoresizingMaskIntoConstraints = false
        return timerCounter
    }()
    
    //MARK: - Question
    let questionLabel : UILabel = {
        let questionLabel = UILabel()
        questionLabel.textAlignment = .center
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0
        questionLabel.text = "Test"
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        return questionLabel
    }()
    
    //MARK: - Answers Section
    let answersStack : UIStackView = {
        let answersStack = UIStackView()
        answersStack.axis = .vertical
        answersStack.spacing = 16
        answersStack.translatesAutoresizingMaskIntoConstraints = false
        return answersStack
    }()
    
    let answerButtonsTitles = ["A": "Title1", "B": "Title2", "C": "Title3", "D": "Title4"]
    var answersButton = [UIButton]()
    
    private func createAnswerButton(letter: String, title: String) -> UIButton {
        let button = UIButton()
        let titleText = NSMutableAttributedString()
        titleText.append(
            NSAttributedString(
                string: "\(letter): ",
                attributes: [.foregroundColor: UIColor(red: 225/255, green: 155/255, blue: 48/255, alpha: 1)]
            )
        )
        titleText.append(
            NSAttributedString(
                string: title,
                attributes: [.foregroundColor: UIColor.white]
            )
        )
        button.setImage(UIImage(named: "plain_answer"), for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    //MARK: - Hints Section
    let hintsStack : UIStackView = {
        let hintsStack = UIStackView()
        hintsStack.axis = .horizontal
        hintsStack.spacing = 24
        hintsStack.translatesAutoresizingMaskIntoConstraints = false
        return hintsStack
    }()
    
    let hintButtonsImages = ["50_50", "audience", "call"]
    var hintButtons = [UIButton]()
    
    private func createHintButton(image: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: image), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(backgroundImage)
        
        
        
        
        
        for (key, value) in answerButtonsTitles {
            answersButton.append(createAnswerButton(letter: key, title: value))
        }
        
    }
}
