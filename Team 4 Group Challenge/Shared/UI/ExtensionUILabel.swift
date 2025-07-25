//
//  ExtensionUILabel.swift
//  Team 4 Group Challenge
//
//  Created by Евгений Васильев on 24.07.2025.
//
import UIKit

extension UILabel {
    func pulse(scale: CGFloat = 1.1, duration: TimeInterval = 0.2) {
        UIView.animate(
            withDuration: duration,
            animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            },
            completion: { _ in
                UIView.animate(withDuration: duration) {
                    self.transform = .identity
                }
            }
        )
    }
}
