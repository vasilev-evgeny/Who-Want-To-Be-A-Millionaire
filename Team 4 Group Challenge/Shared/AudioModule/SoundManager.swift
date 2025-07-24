//
//  SoundManager.swift
//  Team 4 Group Challenge
//
//  Created by Mariia on 24.07.2025.
//
import AVFoundation

// вызывать звук так -> SoundManager.shared.play(.background)

final class SoundManager {
    
    static let shared = SoundManager()
    
    private var player: AVAudioPlayer?
    
    enum SoundType: String {
        case background = "background_music"
        case correct = "correct_answer"
        case wrong = "wrong_answer"
        case suspense = "suspense_music"
    }
    
    func play(_ soundType: SoundType) {
        playSound(soundType.rawValue)
    }
    
    private func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Звук \(soundName) не найден")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Не получилось воспроизвести звук \(soundName): \(error.localizedDescription)")
        }
    }
}
