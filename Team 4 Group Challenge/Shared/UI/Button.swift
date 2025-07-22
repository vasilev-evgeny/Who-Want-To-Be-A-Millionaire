//
//  Button.swift
//  Team 4 Group Challenge
//
//  Created by Mariia on 22.07.2025.
//

import UIKit

final class Button: UIButton {
    var onTap: (() -> Void)?

    var titleText: String {
        get { title(for: .normal) ?? "" }
        set { setTitle(newValue, for: .normal) }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonConfigure()
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtonConfigure()
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    private func setupButtonConfigure() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel?.textAlignment = .center
        
        translatesAutoresizingMaskIntoConstraints = false
        
        clipsToBounds = true
    }

    func applyBackground(named imageName: String) {
        setBackgroundImage(UIImage(named: imageName), for: .normal)
    }

    @objc private func tapped() {
        onTap?()
    }
}
