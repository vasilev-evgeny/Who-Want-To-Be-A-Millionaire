//
//  ViewController.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 20.07.2025.
//

import UIKit

class SplashViewController: BaseViewController {

    enum Constants {
        
    }
    
    //MARK: - Create UI

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(logoImageView)
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 267).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 267).isActive = true
    }

}

