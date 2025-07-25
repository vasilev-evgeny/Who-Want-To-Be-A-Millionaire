//
//  AnswerModule.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 20.07.2025.
//
import UIKit

class AnswerViewController: BaseViewController {
    //MARK: - Properties
    private var answers: [Answer]
    private var isShowContinueButton: Bool
    
    //MARK: - Create UI
    private let gameLogoImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(resource: .gameLogo)
        imageView.image = image
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    private lazy var getMoneyButton = {
        let button = ExtendedHitButton()
        button.extendSize = 20
        button.setImage(UIImage(resource: .getMoneyIco ), for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.getMoneyButtonPressed()
        }), for: .touchUpInside)
        button.isHidden = !isShowContinueButton
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private lazy var continueButton = {
        let button = Button()
        button.titleText = "Continue"
        button.applyBackground(named: "BlueButton")
        ///Запускает таймер и музыку после закрытия
        button.onTap = { [weak self] in
            self?.continueButtonPressed() { [weak self] in
                guard let gameVC = self?.navigationController?.topViewController as? GameViewController else { return }
                CountdownTimer.shared.startTimer(viewController: gameVC)
                SoundManager.shared.play(.background)
            }
        }
        button.isHidden = !isShowContinueButton
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private lazy var tableView = {
        let table = UITableView()
        table.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.identifire)
        table.isScrollEnabled = false
        table.backgroundColor = .clear
        table.rowHeight = view.frame.height / 22.5
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.contentInset = .init(top: 4, left: 0, bottom: 0, right: 0)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    //MARK: - Lifecycle
    init(answers: [Answer], isShowContinueButton: Bool = false) {
        self.isShowContinueButton = isShowContinueButton
        self.answers = answers
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    //MARK: - Methods
    private func getMoneyButtonPressed() {
        let currentQuestion = GameBrain.shared.currentQuestion
        let money = GameBrain.shared.currentPrize
        SoundManager.shared.stopMusic()
        let resultVC = ResultViewController(moneyWon: money , finalAnswerCount: currentQuestion)
        navigationController?.pushViewController(resultVC, animated: true)
    }
    private func continueButtonPressed(completition: (() -> Void)) {
        navigationController?.popViewController(animated: true)
        completition()
    }
    //MARK: - setLayout
    private func setupViews() {
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - setConstraints
    private func setConstraints() {
        view.addSubview(getMoneyButton)
        view.addSubview(tableView)
        view.addSubview(logoImageView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 4.3),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            getMoneyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            getMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getMoneyButton.widthAnchor.constraint(equalToConstant: view.frame.width / 18.75),
            getMoneyButton.heightAnchor.constraint(equalTo: getMoneyButton.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 146),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            continueButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2.6),
            continueButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

//MARK: - TableView Delegate and DataSource
extension AnswerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifire, for: indexPath) as! AnswerCell
        cell.selectionStyle = .none
        let answer = answers[indexPath.row]
        cell.configure(with: answer)
        
        return cell
    }
}
