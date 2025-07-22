//
//  BaseViewController.swift
//  Team 4 Group Challenge
//
//  Created by Mariia on 22.07.2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Create UI
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "GameMillionaireIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 67
        imageView.layer.masksToBounds = false
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
    }
    

    private func setupViews() {
        view.addSubview(backgroundImageView)
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }


}
