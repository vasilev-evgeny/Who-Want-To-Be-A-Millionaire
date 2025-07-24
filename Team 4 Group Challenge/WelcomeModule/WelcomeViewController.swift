//
//  Untitled.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 20.07.2025.
//
import UIKit

class WelcomeViewController: UIViewController {
        
    //MARK: - Create UI
    
    //Buttons
    lazy var buttonRules: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "helpBtn"), for: .normal)
        $0.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
        return $0
    } (UIButton())
    
    lazy var buttonNewGame: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("New game", for: .normal)
        $0.setBackgroundImage(UIImage(named: "yellowBtn"), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(newGameButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var buttonContinueGame: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Continue game", for: .normal)
        $0.setBackgroundImage(UIImage(named:"yellowBtn"), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        $0.isHidden = true
        return $0
    }(UIButton())
    
    
    //Images
    lazy var bgImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "bgImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    lazy var logoImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logoImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = false
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 20
        $0.layer.shadowOpacity = 0.5
        return $0
    }(UIImageView())
    
    //Label
    lazy var labelText: UILabel = {
        $0.text = "Who Wants \nto be a Millionaire"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 32, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    //MARK: - Action Func
    
    @objc func rulesButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        let controller = RulesViewController()
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .coverVertical
        self.navigationController?.pushViewController(controller, animated: true)
        controller.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func continueButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        let gameVC = GameViewController()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc func newGameButtonTapped(sender : UIButton) {
        sender.buttonTappedAnimate()
        GameBrain.shared.isGameInProgress = true
        print(GameBrain.shared.isGameInProgress)
        GameBrain.shared.refreshGame()
        let gameVC = GameViewController()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    func checkGameStatus() {
        switch GameBrain.shared.isGameInProgress {
        case true :
            buttonContinueGame.isHidden = false
            buttonNewGame.setBackgroundImage(UIImage(named: "BlueButton"), for: .normal)
        case false:
            buttonContinueGame.isHidden = true
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        checkGameStatus()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemPink
        view.addSubview(bgImage)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonRules)
        view.addSubview(buttonRules)
        view.addSubview(logoImage)
        view.addSubview(labelText)
        view.addSubview(buttonNewGame)
        view.addSubview(buttonContinueGame)
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        
        
        NSLayoutConstraint.activate([
            
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            buttonRules.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            buttonRules.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 323),
            buttonRules.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            logoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -449),
            
            
            labelText.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            labelText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 58),
            labelText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -58),
            
            buttonNewGame.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            buttonNewGame.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            buttonNewGame.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -109),
            
            buttonContinueGame.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            buttonContinueGame.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            buttonContinueGame.bottomAnchor.constraint(equalTo: buttonNewGame.topAnchor, constant: -20),
            buttonContinueGame.heightAnchor.constraint(equalTo: buttonNewGame.heightAnchor),
            
        ])
        
    }
    
}
