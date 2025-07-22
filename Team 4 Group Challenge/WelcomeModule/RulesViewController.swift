//
//  RulesViewController.swift
//  Team 4 Group Challenge
//
//  Created by Никита Грицунов on 22.07.2025.
//

import UIKit

class RulesViewController: UIViewController {
    
    let rulesTextIntroBlock = """
        Who wants to become a millionaire?
                
        An intellectual game with questions and a choice of answers. 
        
        The goal of the game is to reach the sum of one million dollars.
        To achieve this goal, the player must correctly answer 15 questions.
        questions from various fields of knowledge. The time for reflection is limited to 24 seconds. The difficulty of the game increases with each new question.

        The questions have four possible answers, of which only one is correct. 
        Each question has a specific cost that cannot be combined with 
        the previous one, but is replaced with a new one if the answer is correct.
        """
    let rulesTextCurrentLevelBlock = """
        You can view the current level by clicking on the button in the upper-right corner of the screen.
    """
    let rulesTextSafeAmountBlock = """
        There are two fireproof amounts. When this amount is reached, the player's score will not drop below in case of a draw or if the player wants to stop the game. 
    
        There are 3 hints available to the player:
    """
    
    let rulesTextHintsBlock = """
        50/50 - removes 2 incorrect options and leaves one correct and one incorrect 
        The help of the hall - the player can use the answer offered by the hall
                
        Call a friend - the player can call a friend and consult with him within 30 seconds.

        The game ends if the player answers 15 questions correctly or after the first mistake.
        """
    
    
    //MARK: - UI

    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.text = "Rules"
        element.font = .systemFont(ofSize: 18, weight: .semibold)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 20
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var rulesIntroLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17)
        element.text = rulesTextIntroBlock
        element.numberOfLines = 0
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
        
    }()
    
    private lazy var levelsImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "LevelRules")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var rulesCurrentLevelLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17)
        element.text = rulesTextCurrentLevelBlock
        element.numberOfLines = 0
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var levelsButtonImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "Levels button")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var rulesSafeAmountLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17)
        element.text = rulesTextSafeAmountBlock
        element.numberOfLines = 0
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
        
    }()
    
    private lazy var hintsButtonImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "Hints")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var rulesTextHintsLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17)
        element.text = rulesTextHintsBlock
        element.numberOfLines = 0
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
        
    }()
    
    private lazy var closeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action Func
    
    @objc func closeButtonTapped() {
        let controller = WelcomeViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
    }
}



//MARK: - Set Views and Set Constraints

extension RulesViewController {
    private func setViews() {
        view.backgroundColor = UIColor(red: (48 / 255), green: (52 / 255), blue: (68 / 255), alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        
        
        mainStackView.addArrangedSubview(rulesIntroLabel)
        mainStackView.addArrangedSubview(levelsImageView)
        mainStackView.addArrangedSubview(rulesCurrentLevelLabel)
        mainStackView.addArrangedSubview(levelsButtonImageView)
        mainStackView.addArrangedSubview(rulesSafeAmountLabel)
        mainStackView.addArrangedSubview(hintsButtonImageView)
        mainStackView.addArrangedSubview(rulesTextHintsLabel)

        scrollView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            rulesIntroLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -40),
            rulesCurrentLevelLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -40),
            rulesSafeAmountLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -40),
            rulesTextHintsLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -40),
            
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        
    }
}
