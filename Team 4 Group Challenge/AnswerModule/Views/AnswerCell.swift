//
//  AnswerCell.swift
//  Team 4 Group Challenge
//
//  Created by Andrei Kovryzhenko on 22.07.2025.
//

import UIKit

class AnswerCell: UITableViewCell {
    //MARK: - Properties
    static let identifire = "Cell"
    
    // MARK: - UI Components
    private let backgroundImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    private let countLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let moneyLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    public func configure(with answer: Answer) {
        countLabel.text = "\(answer.questionNumber):"
        moneyLabel.text = "$ \(answer.questionPrice)"
        
        switch answer.type {
        case .regular:
            backgroundImageView.image = UIImage(resource: .moneyCellBackgroundRegular)
        case .safe:
            backgroundImageView.image = UIImage(resource: .moneyCellBackgroundSafe)
        case .top:
            backgroundImageView.image = UIImage(resource: .moneyCellBackgroundTop)
        }
        
        if answer.isCurrent {
            backgroundImageView.image = UIImage(resource: .moneyCellBackgroundCurrent)
        }
    }
    
    //MARK: - Setup Layout
    private func makeLayout() {
        backgroundColor = .clear
        setConstraints()
    }
    
    //MARK: - setConstraints
    private func setConstraints() {
        addSubview(backgroundImageView)
        addSubview(countLabel)
        addSubview(moneyLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: -3),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            countLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 30),
            
            moneyLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            moneyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
    
}
