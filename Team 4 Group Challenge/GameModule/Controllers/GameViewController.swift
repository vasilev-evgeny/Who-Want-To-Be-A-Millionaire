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

    
    let game = GameBrain.shared
    
    //MARK: - Create UI Items
    
    let mainView : UIImageView = {
        let mainView = UIImageView(image: UIImage(named: "Background"))
        mainView.isUserInteractionEnabled = true
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
    
    let chartButton : UIButton = {
        let chartButton = UIButton()
        chartButton.backgroundColor = .clear
        chartButton.setImage(UIImage(named: "barChart"), for: .normal)
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
        let timerImage = UIImageView()
        timerImage.translatesAutoresizingMaskIntoConstraints = false
        timerImage.image?.withRenderingMode(.alwaysTemplate)
        
        // Делаем timerImage tintable
        if let image = UIImage(named: "stopwatch") {
            let tintedTimerImage = image.withRenderingMode(.alwaysTemplate)
            timerImage.image = tintedTimerImage
            timerImage.tintColor = .white
        }
        
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
        questionTextView.textContainer.lineFragmentPadding = 0
        questionTextView.textContainerInset = .zero
        questionTextView.textContainer.lineFragmentPadding = 0
        questionTextView.layer.borderWidth = 0
        questionTextView.backgroundColor = .clear
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        return questionTextView
    }()
    
    //MARK: - Answers Section
    var answersStack : UIStackView = {
        let answersStack = UIStackView()
        answersStack.axis = .vertical
        answersStack.spacing = 16
        answersStack.distribution = .fillEqually
        answersStack.translatesAutoresizingMaskIntoConstraints = false
        return answersStack
    }()
    
    var answersButtonArray = [UIButton]()
    
    private func createAnswerButton(letter: Int, title: String) -> UIButton {
        let button = UIButton()
        let letters = ["A","B", "C", "D"]
        let titleText = NSMutableAttributedString()
        titleText.append(attributedText(text: "\(letters[letter]):  ", fontSize: 18, color: UIColor(red: 225/255, green: 155/255, blue: 48/255, alpha: 1), firstLineIntend: 30))
        titleText.append(attributedText(text: title, fontSize: 18, color: .white))
        button.setBackgroundImage(UIImage(named: "BlueButton"), for: .normal)
        button.setAttributedTitle(titleText, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    //MARK: - Hints Section
    var hintsStack : UIStackView = {
        let hintsStack = UIStackView()
        hintsStack.axis = .horizontal
        hintsStack.alignment = .fill
        hintsStack.distribution = .fill
        hintsStack.spacing = 24
        hintsStack.translatesAutoresizingMaskIntoConstraints = false
        return hintsStack
    }()
    
    
    var hintButtons = [UIButton]()
    
    private func createHintButton(image: String, state: Bool) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        button.isEnabled = state
        button.alpha = state ? 1 : 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard !game.isGameOver else {
            return gameOver()
        }
        setupUI()
        CountdownTimer.shared.startTimer(viewController: self)
        SoundManager.shared.play(.background)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
            backButton.addTarget(self, action: #selector(pushBackButton), for: .touchUpInside)
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButtonContainter)
            
            chartButtonContainter.addSubview(chartButton)
            NSLayoutConstraint.activate([
                chartButtonContainter.heightAnchor.constraint(equalToConstant: 44),
                chartButtonContainter.widthAnchor.constraint(equalToConstant: 32),
                
                chartButton.topAnchor.constraint(equalTo: chartButtonContainter.topAnchor),
                chartButton.centerXAnchor.constraint(equalTo: chartButtonContainter.centerXAnchor),
            ])
            chartButton.addTarget(self, action: #selector(pushChartButton), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: chartButtonContainter)
            
            labelStack.addArrangedSubview(topTitleLabel)
            labelStack.addArrangedSubview(bottomTitleLabel)
            
            navigationItem.titleView = labelStack
            topTitleLabel.attributedText = attributedText(text: "QUESTION #\(game.currentQuestion + 1)", fontSize: 18, color: .white)
            bottomTitleLabel.attributedText = attributedText(text: "$\(game.currentPrize)", fontSize: 19, color: .white)
            
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
            timerCounter.attributedText = attributedText(text: "30", fontSize: 22, color: .white)

            
            //MARK: - Question Section UI
            mainView.addSubview(questionTextView)
            NSLayoutConstraint.activate([
                questionTextView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 24),
                questionTextView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
                questionTextView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32),
                questionTextView.heightAnchor.constraint(equalToConstant: 147)
            ])
            questionTextView.attributedText = attributedText(text: game.sharedGameQuestions[game.currentQuestion].question, fontSize: 24, color: .white)
            
            //MARK: - Answers Section UI
            mainView.addSubview(answersStack)
            NSLayoutConstraint.activate([
                answersStack.topAnchor.constraint(equalTo: questionTextView.bottomAnchor, constant: 32),
                answersStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
                answersStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32),
                answersStack.heightAnchor.constraint(equalToConstant: 272)
            ])
            let answerButtonsTitles = game.sharedGameQuestions[game.currentQuestion].answers.shuffled()
            
            for (key, value) in answerButtonsTitles.enumerated() {
                answersButtonArray.append(createAnswerButton(letter: key, title: value))
            }
            answersButtonArray.forEach {
                answersStack.addArrangedSubview($0)
            }
           
            //MARK: - Hints UI
            mainView.addSubview(hintsStack)
            NSLayoutConstraint.activate([
                hintsStack.topAnchor.constraint(equalTo: answersStack.bottomAnchor, constant: 40),
                hintsStack.centerXAnchor.constraint(equalTo: answersStack.centerXAnchor),
                hintsStack.heightAnchor.constraint(equalToConstant: 64)
            ])
            game.hintButtons.forEach {
                hintButtons.append(createHintButton(image: $0.0, state: $0.1))
            }
            hintButtons.forEach {
                hintsStack.addArrangedSubview($0)
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
    
    //MARK: - Action Func
    
    func upgradeRecord() {
        print("олл тайм рекорд \(game.allTimeRecord)")
        UserDefaults.standard.set("\(self.game.allTimeRecord)", forKey: "allTimeRecord")
        print("юзер дифолт вот такой сейчас по идее \(UserDefaults.standard.string(forKey: "allTimeRecord"))")
        UserDefaults.standard.synchronize()
    }
    
    @objc func pushBackButton(sender: UIButton) {
        sender.buttonTappedAnimate()
        SoundManager.shared.stopMusic()
        let targetVC = WelcomeViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
        targetVC.navigationItem.hidesBackButton = true
    }
    
    @objc func pushChartButton(sender: UIButton) {
        sender.buttonTappedAnimate()
        let targetVC = AnswerModule(answers: Answer.getAnswerList())
        self.navigationController?.pushViewController(targetVC, animated: true)
        targetVC.navigationItem.hidesBackButton = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func answerButtonPressed(_ sender: Button) {
        sender.buttonTappedAnimate()
        SoundManager.shared.play(.suspense)
        CountdownTimer.shared.stopTimer()
        sender.setBackgroundImage(UIImage(named: "YellowButton"), for: .normal)
        guard let title = sender.currentAttributedTitle?.string else { return }
        
        
        let isCorrectAnswer = title.hasSuffix(game.sharedGameQuestions[game.currentQuestion].correctAnswer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if isCorrectAnswer {
                SoundManager.shared.play(.correct)
                sender.setBackgroundImage(UIImage(named: "right_answer"), for: .normal)
                sender.blink()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.game.guaranteedPrize =  (self.game.currentQuestion + 1) % 5 == 0 ? self.game.currentPrize : self.game.guaranteedPrize
                    self.awakeAnswerModule()
                    if self.game.currentQuestion == (self.game.sharedGameQuestions.count - 1) {
                        self.gameOver()
                    } else {
                        self.game.currentQuestion += 1
                        self.clearStack(for: &self.answersStack)
                        
                        self.clearStack(for: &self.hintsStack)
                        self.answersButtonArray = []
                        self.hintButtons = []
                        self.setupUI()
                        if self.game.currentPrize > self.game.allTimeRecord {
                            self.game.allTimeRecord = self.game.currentPrize
                            self.upgradeRecord()
                        }
                    }
                }
                
            }
            else {
                SoundManager.shared.play(.wrong)
                sender.setBackgroundImage(UIImage(named: "wrong_answer"), for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.gameOver()
                }
            }
        }
    }
    
    func awakeAnswerModule() {
        let targetVC = AnswerModule(answers: Answer.getAnswerList())
        self.navigationController?.pushViewController(targetVC, animated: true)
        targetVC.navigationItem.hidesBackButton = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.navigationController?.popViewController(animated: true)
            CountdownTimer.shared.startTimer(viewController: self)
            SoundManager.shared.play(.background)
        }
        
    }
    
    func gameOver() {
        let targetVC = ResultViewController()
        GameBrain.shared.isGameInProgress = false
        self.navigationController?.pushViewController(targetVC, animated: true)
        targetVC.navigationItem.hidesBackButton = true
    }
    
    func clearStack(for stack: inout UIStackView) {
        for subview in stack.arrangedSubviews {
            stack.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}

//MARK: - Extension UIView

extension UIView {
    func blink(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, alpha: CGFloat = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut, .repeat, .autoreverse]) {
            self.alpha = alpha
        }
    }
}
