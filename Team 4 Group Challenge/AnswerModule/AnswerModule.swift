//
//  AnswerModule.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 20.07.2025.
//
import UIKit

class AnswerViewController: UIViewController {
    //MARK: - Properties
    var answers: [Answer]
    
    //MARK: - Create UI
    private let backgroundImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(resource: .background)
        imageView.image = image
        
        return imageView
    }()
    private let logoImageView = {
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
    init(answers: [Answer]) {
        self.answers = Answer.getAnswerList()
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
    //MARK: - Methods
    private func getMoneyButtonPressed() {
    //TODO: - Make open score view and finish game
        ///This function just for checking the action
        print(#function)
        for i in 0..<answers.count {
            if answers[i].isCurrent {
                answers[i].isCurrent = false
                if i > 0 {
                    answers[i-1].isCurrent = true
                } else {
                    answers[14].isCurrent = true
                    break
                }
            }
        }
        tableView.reloadData()
    }
    //MARK: - setLayout
    private func setupViews() {
        setBackground()
    }
    private func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.bounds
    }
    
    //MARK: - setConstraints
    private func setConstraints() {
        view.addSubview(getMoneyButton)
        view.addSubview(tableView)
        view.addSubview(logoImageView)
        
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

//#Preview {
//    AnswerViewController(answers: Answer.getAnswerList())
//}
