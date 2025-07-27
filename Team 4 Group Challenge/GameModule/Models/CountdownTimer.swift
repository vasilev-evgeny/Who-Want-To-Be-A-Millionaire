//
//  Timer.swift
//  Team 4 Group Challenge
//
//  Created by Никита Грицунов on 24.07.2025.
//

import UIKit

final class CountdownTimer {
    
    var secondsRemaining = 30
    var timer: Timer? = Timer()
    var gameVC: GameViewController?
    static let shared = CountdownTimer()
    

    func startTimer(viewController: GameViewController) {
        stopTimer()
        gameVC = viewController
        secondsRemaining = 30
        gameVC?.timerView.layer.backgroundColor = UIColor.regularTimerView.cgColor
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
        gameVC?.timerCounter.pulse()

        if secondsRemaining == 15 {
            gameVC?.timerCounter.pulse()
            UIView.animate(withDuration: 0.4) {
                self.gameVC?.timerView.layer.backgroundColor = UIColor.warningTimerView.cgColor
                self.gameVC?.timerImage.tintColor = UIColor.warningTimer
                self.gameVC?.timerCounter.textColor = UIColor.warningTimerCounter
            }
            
        } else if secondsRemaining == 5 {
            gameVC?.timerCounter.pulse()
            UIView.animate(withDuration: 0.4) {
                self.gameVC?.timerView.layer.backgroundColor = UIColor.alertTimerView.cgColor
                self.gameVC?.timerImage.tintColor = UIColor.alertTimer
                self.gameVC?.timerCounter.textColor = UIColor.alertTimerCounter
            }
        } else if secondsRemaining == 0 {
            stopTimer()
            gameVC?.answersButtonArray.forEach { $0.isEnabled = false }
            gameVC?.hintButtons.forEach { $0.isEnabled = false }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.gameVC?.gameOver()
                SoundManager.shared.play(.wrong)
            }
        }
    }
    
}
