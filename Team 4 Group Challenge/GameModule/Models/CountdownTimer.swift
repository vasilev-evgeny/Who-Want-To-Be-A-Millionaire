//
//  Timer.swift
//  Team 4 Group Challenge
//
//  Created by Никита Грицунов on 24.07.2025.
//

import UIKit

class CountdownTimer {
    
    var secondsRemaining = 30
    var timer: Timer? = Timer()
    var gameVC: GameViewController?
    

    func startTimer(viewController: GameViewController) {
        gameVC = viewController
        secondsRemaining = 30
        gameVC?.timerView.layer.backgroundColor = UIColor.regularTimerView?.cgColor
        gameVC?.timerImage.tintColor = UIColor.regularTimer
        gameVC?.timerCounter.textColor = UIColor.regularTimerCounter
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUIByTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateUIByTimer() {
        secondsRemaining -= 1
        gameVC?.timerCounter.text = String(secondsRemaining)
         
        if secondsRemaining == 10 {
            
            gameVC?.timerView.layer.backgroundColor = UIColor.warningTimerView?.cgColor
            gameVC?.timerImage.tintColor = UIColor.warningTimer
            gameVC?.timerCounter.textColor = UIColor.warningTimerCounter

        } else if secondsRemaining == 3 {
            
            gameVC?.timerView.layer.backgroundColor = UIColor.alertTimerView?.cgColor
            gameVC?.timerImage.tintColor = UIColor.alertTimer
            gameVC?.timerCounter.textColor = UIColor.alertTimerCounter
            
        } else if secondsRemaining == 0 {
            stopTimer()
        }
    }
    
}
