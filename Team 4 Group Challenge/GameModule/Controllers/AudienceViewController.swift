//
//  AudienceViewController.swift
//  Team 4 Group Challenge
//
//  Created by Andrei Kovryzhenko on 25.07.2025.
//

import UIKit

class AudienceViewController: BaseViewController {
    let audienceAnswer: [CGFloat]
    let answerBarChart: AudienceHint = {
            let audienceHint = AudienceHint()
        audienceHint.translatesAutoresizingMaskIntoConstraints = false
            return audienceHint
        }()

    init(audienceAnswer: [CGFloat]) {
        self.audienceAnswer = audienceAnswer
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(answerBarChart)
//        answerLabel.text = audienceAnswer

        NSLayoutConstraint.activate([
            answerBarChart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerBarChart.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            answerBarChart.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            answerBarChart.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)
        ])
        answerBarChart.setBarValues(audienceAnswer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.dismiss(animated: true)
        }
    }
}
