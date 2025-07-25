//
//  Untitled.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 20.07.2025.
//
import UIKit

class GameViewController: UIViewController {
    
    enum Constants {
    }
    //MARK: - Create UI Items
    
    let mainView : UIImageView = {
        let mainView = UIImageView(image: UIImage(named: "Background"))
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    //MARK: - NavigationBar
    
    let backButton : UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    let backButtonContainter : UIView = {
        let backButtonContainter = UIView()
        backButtonContainter.translatesAutoresizingMaskIntoConstraints = false
        return backButtonContainter
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
        topTitleLabel.text = "QUESTION #"
        topTitleLabel.textColor = .white
        topTitleLabel.font = UIFont.systemFont(ofSize: 18)
        topTitleLabel.alpha = 0.5
        topTitleLabel.textAlignment = .center
        topTitleLabel.backgroundColor = .clear
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return topTitleLabel
    }()
    
    let bottomTitleLabel : UILabel = {
        let bottomTitleLabel = UILabel()
        bottomTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return bottomTitleLabel
    }()
    
    private lazy var chartButton : UIButton = {
        let chartButton = UIButton()
        chartButton.backgroundColor = .clear
        chartButton.setImage(UIImage(named: "barChart"), for: .normal)
        chartButton.addAction(UIAction(handler: { [weak self] _ in
            self?.chartButtonPressed()
        }), for: .touchUpInside)
        chartButton.translatesAutoresizingMaskIntoConstraints = false
        return chartButton
    }()
    
    let chartButtonContainter : UIView = {
        let chartButtonContainter = UIView()
        chartButtonContainter.translatesAutoresizingMaskIntoConstraints = false
        return chartButtonContainter
    }()
    
    //MARK: - Timer
    
    let timerView : UIView = {
        let timerView = UIView()
        timerView.layer.cornerRadius = 22.5
        timerView.clipsToBounds = true
        timerView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        timerView.translatesAutoresizingMaskIntoConstraints = false
        return timerView
    }()
    
    let timerImage : UIImageView = {
        let timerImage = UIImageView(image: UIImage(named: "stopwatch"))
        timerImage.translatesAutoresizingMaskIntoConstraints = false
        return timerImage
    }()
    
    let timerCounter : UILabel = {
        let timerCounter = UILabel()
        timerCounter.translatesAutoresizingMaskIntoConstraints = false
        return timerCounter
    }()
    
    //MARK: - Question
    let questionTextView : UITextView = {
        let questionTextView = UITextView()
        questionTextView.isEditable = false
        questionTextView.isSelectable = false
        questionTextView.isScrollEnabled = false
        questionTextView.clipsToBounds = true
        questionTextView.textContainerInset = .zero
        questionTextView.textContainer.lineFragmentPadding = 0
        questionTextView.layer.borderWidth = 0
        questionTextView.backgroundColor = .clear
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        return questionTextView
    }()
    
    //MARK: - Answers Section
    let answersStack : UIStackView = {
        let answersStack = UIStackView()
        answersStack.axis = .vertical
        answersStack.spacing = 16
        answersStack.distribution = .fillEqually
        answersStack.translatesAutoresizingMaskIntoConstraints = false
        return answersStack
    }()
    
    let answerButtonsTitles = ["A": "Title1", "B": "Title2", "C": "Title3", "D": "Title4"]
    var answersButtonArray = [UIButton]()
    
    private func createAnswerButton(letter: String, title: String) -> UIButton {
        let button = UIButton()
        let titleText = NSMutableAttributedString()
        titleText.append(attributedText(text: "\(letter):  ", fontSize: 18, color: UIColor(red: 225/255, green: 155/255, blue: 48/255, alpha: 1), firstLineIntend: 30))
        titleText.append(attributedText(text: title, fontSize: 18, color: .white))
        button.setBackgroundImage(UIImage(named: "BlueButton"), for: .normal)
        button.setAttributedTitle(titleText, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    //MARK: - Hints Section
    let hintsStack : UIStackView = {
        let hintsStack = UIStackView()
        hintsStack.axis = .horizontal
        hintsStack.alignment = .fill
        hintsStack.distribution = .fill
        hintsStack.spacing = 24
        hintsStack.translatesAutoresizingMaskIntoConstraints = false
        return hintsStack
    }()
    
    let hintButtonsImages = ["50_50", "audience", "call"]
    var hintButtons = [UIButton]()
    
    private func createHintButton(image: String) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupViews() {
        func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    //MARK: - Methods
    
    private func chartButtonPressed() {
        showAnswerModule()
    }
    
    //MARK: - Setup UI
    
    func setupUI() {
        
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //MARK: - NavigationBar UI
        
        backButtonContainter.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButtonContainter.heightAnchor.constraint(equalToConstant: 44),
            backButtonContainter.widthAnchor.constraint(equalToConstant: 32),
            
            backButton.topAnchor.constraint(equalTo: backButtonContainter.topAnchor),
            backButton.centerXAnchor.constraint(equalTo: backButtonContainter.centerXAnchor),
        ])
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButtonContainter)
        
        chartButtonContainter.addSubview(chartButton)
        NSLayoutConstraint.activate([
            chartButtonContainter.heightAnchor.constraint(equalToConstant: 44),
            chartButtonContainter.widthAnchor.constraint(equalToConstant: 32),
            
            chartButton.topAnchor.constraint(equalTo: chartButtonContainter.topAnchor),
            chartButton.centerXAnchor.constraint(equalTo: chartButtonContainter.centerXAnchor),
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: chartButtonContainter)
        
        labelStack.addArrangedSubview(topTitleLabel)
        labelStack.addArrangedSubview(bottomTitleLabel)
        
        navigationItem.titleView = labelStack
        bottomTitleLabel.attributedText = attributedText(text: "$", fontSize: 19, color: .white)
        
        //MARK: - Timer UI
        
        mainView.addSubview(timerView)
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 54.5),
            timerView.heightAnchor.constraint(equalToConstant: 45),
            timerView.widthAnchor.constraint(equalToConstant: 91)
        ])
        
        timerView.addSubview(timerImage)
        NSLayoutConstraint.activate([
            timerImage.topAnchor.constraint(equalTo: timerView.topAnchor, constant: 10.5),
            timerImage.leadingAnchor.constraint(equalTo: timerView.leadingAnchor, constant: 17),
            timerImage.widthAnchor.constraint(equalToConstant: 24),
            timerImage.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        timerView.addSubview(timerCounter)
        NSLayoutConstraint.activate([
            timerCounter.topAnchor.constraint(equalTo: timerView.topAnchor, constant: 8),
            timerCounter.leadingAnchor.constraint(equalTo: timerImage.trailingAnchor, constant: 8),
            timerCounter.widthAnchor.constraint(equalToConstant: 27),
            timerCounter.heightAnchor.constraint(equalToConstant: 29)
        ])
        timerCounter.attributedText = attributedText(text: "60", fontSize: 22, color: .white)
        
        //MARK: - Question Section UI
        mainView.addSubview(questionTextView)
        NSLayoutConstraint.activate([
            questionTextView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 24),
            questionTextView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            questionTextView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32),
            questionTextView.heightAnchor.constraint(equalToConstant: 147)
        ])
        questionTextView.attributedText = attributedText(text: "What year was the year, when first deodorant was invented in our life?", fontSize: 24, color: .white)
        
        //MARK: - Answers Section UI
        mainView.addSubview(answersStack)
        NSLayoutConstraint.activate([
            answersStack.topAnchor.constraint(equalTo: questionTextView.bottomAnchor, constant: 32),
            answersStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            answersStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32),
            answersStack.heightAnchor.constraint(equalToConstant: 272)
        ])
        let sortedAnswerButtonsTitles = answerButtonsTitles.sorted { $0.key < $1.key }
        for (key, value) in sortedAnswerButtonsTitles {
            answersButtonArray.append(createAnswerButton(letter: key, title: value))
        }
        answersButtonArray.forEach { answersStack.addArrangedSubview($0)
        }
        
        //MARK: - Hints UI
        mainView.addSubview(hintsStack)
        NSLayoutConstraint.activate([
            hintsStack.topAnchor.constraint(equalTo: answersStack.bottomAnchor, constant: 40),
            hintsStack.centerXAnchor.constraint(equalTo: answersStack.centerXAnchor),
            hintsStack.heightAnchor.constraint(equalToConstant: 64),
            //            hintsStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            //            hintsStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32)
        ])
        hintButtonsImages.forEach {
            hintButtons.append(createHintButton(image: $0))
        }
        hintButtons.forEach {
            hintsStack.addArrangedSubview($0)
            //            $0.widthAnchor.constraint(equalToConstant: 84).isActive = true
            //            $0.heightAnchor.constraint(equalToConstant: 64).isActive = true
        }
        
    }
    //MARK: func attributedText
    func attributedText(text: String, fontSize: CGFloat, color: UIColor, firstLineIntend: CGFloat = 0) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = firstLineIntend
        paragraphStyle.alignment = .center
        let attributes : [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .semibold),
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        return NSAttributedString(string: text, attributes: attributes)
        
    }
    /// метод показывает AnswerModule с текущим вопросом
    private func showAnswerModule() {
        var answers = GameBrain.shared.answers
        let cur = 14 - GameBrain.shared.currentQuestion
        answers[cur].isCurrent = true
        let vc = AnswerViewController(answers: answers)
        navigationController?.pushViewController(vc, animated: true)
    }
    /// метод делает кнопку неактивной и затемняет ее
    private func turnOffHintButton(_ hintNumber: Int) {
        hintButtons[hintNumber].isEnabled = false
        let hideLayer = CALayer()
        hideLayer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        hintButtons[hintNumber].layer.addSublayer(hideLayer)
    }
}

