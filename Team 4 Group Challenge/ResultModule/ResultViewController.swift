//
//  ResultViewController.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 20.07.2025.
//
import UIKit

class ResultViewController: BaseViewController, QuestionManagerDelegate {
    
    enum Constants {

    }
    /// константы для показа результата
    private let moneyWon: String
    private let finalAnswerCount: Int
    private let startNewGameButton = Button()
    private let goToMainScreenButton = Button()
    
    //MARK: - Create UI
    let subtitleLevel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let coinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private lazy var labelWithCoinIconStack: UIStackView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "CoinIcon")
    /// растягивает картинку под размер
        iconView.contentMode = .scaleAspectFill
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        iconView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [iconView, coinLabel])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var resultInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [subtitleLevel, labelWithCoinIconStack])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        /// поправил отображение лейбла
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:  [startNewGameButton, goToMainScreenButton])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        
        [startNewGameButton, goToMainScreenButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 75).isActive = true
        }

        return stack
    }()
    
    //MARK: - Lifecycle
    ///инициализация для констант денег и вопросов
    init(moneyWon: String, finalAnswerCount: Int) {
        self.moneyWon = moneyWon
        self.finalAnswerCount = finalAnswerCount
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /// выводит результат игры
        titleLabel.text = "Game over!"
        subtitleLevel.text = "Level \(finalAnswerCount)"
        coinLabel.text = "$ " + moneyWon
        
        setupViews()
        setConstraints()
        
    }
    
    func didUpdateQuestion(question: [QuestionModal]) {
        print(question)
    }
    ///Скрывает navigationBar перед показом view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(resultInfoStackView)
        view.addSubview(buttonsStack)
        
        startNewGameButton.titleText = "New game"
        startNewGameButton.applyBackground(named: "YellowButton")
        startNewGameButton.onTap = {
            self.startNewGameButton.buttonTappedAnimate()
            GameBrain.shared.isGameInProgress = true
            GameBrain.shared.refreshGame()
            let gameVC = GameViewController()
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
        
        goToMainScreenButton.titleText = "Main screen"
        goToMainScreenButton.applyBackground(named: "BlueButton")
        goToMainScreenButton.onTap = { [weak self] in
            /// удаляет из стэка все контроллеры до рутового
            //TODO: - обнулить данные о предыдущей игре
            self?.navigationController?.popToRootViewController(animated: true)
            self?.navigationController?.navigationBar.isHidden = false
            print("go to main screen")

        }
    }
    
    //MARK: - setConstraints
    private func setConstraints() {
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 122).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        resultInfoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        resultInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        buttonsStack.topAnchor.constraint(equalTo: resultInfoStackView.bottomAnchor, constant: 124).isActive = true
        buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
    }
}

