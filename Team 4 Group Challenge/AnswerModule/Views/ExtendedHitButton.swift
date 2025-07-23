//
//  ExtendedHitButton.swift
//  Team 4 Group Challenge
//
//  Created by Andrei Kovryzhenko on 22.07.2025.
//

import UIKit

class ExtendedHitButton: UIButton {
    var extendSize: CGFloat = 0
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if point.x >= -extendSize &&
            point.x <= bounds.width + extendSize &&
            point.y >= -extendSize &&
            point.y <= bounds.height + extendSize {
            return true
        }
        return false
    }
}

