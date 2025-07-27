//
//  AudienceViewController.swift
//  Team 4 Group Challenge
//
//  Created by Andrei Kovryzhenko on 25.07.2025.
//

import UIKit

class CallFriendViewController: BaseViewController {
    let audienceAnswer: String
    let answerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(audienceAnswer: String) {
        self.audienceAnswer = audienceAnswer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(answerLabel)
        answerLabel.text = audienceAnswer
        
        NSLayoutConstraint.activate([
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.dismiss(animated: true)
        }
    }
}
