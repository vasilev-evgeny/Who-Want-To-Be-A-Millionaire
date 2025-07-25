//
//  ExtensionUIButton.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 24.07.2025.
//
import UIKit

extension UIButton {
    func buttonTappedAnimate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
}
