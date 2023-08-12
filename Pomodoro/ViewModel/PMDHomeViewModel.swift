//
//  PMDHomeViewModel.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 12.08.2023.
//

import Foundation
class PMDHomeViewModel {
    private var mainTimer: Timer?
    private var breakTimer: Timer?
    private var remainingTime: TimeInterval = 5 // 25 dakika
    private var remainingBreakTime : TimeInterval = 3 //5 dakika
    private var isOnBreak = false
    
    var countdownText: ((String) -> Void)?
    var timerCompleted : (() -> Void)?
    var breakCompleted: (() -> Void)?
    
    init() {
        startMainTimer()
    }
    
    
    func startMainTimer() {
        mainTimer?.invalidate()
        mainTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMainCountdown), userInfo: nil, repeats: true)
    }
    
    
    func startBreakTimer() {
        breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakCountdown), userInfo: nil, repeats: true)
    }
    
    @objc private func updateMainCountdown() {
        guard remainingTime > 0 else {
            mainTimer?.invalidate()
            isOnBreak = true
            startBreakTimer()
            timerCompleted?()
            return
        }
        
        remainingTime -= 1
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        countdownText?(formattedTime)
    }
    
    @objc private func updateBreakCountdown() {
        guard remainingBreakTime > 0 else {
            breakTimer?.invalidate()
            breakCompleted?()
            return
        }
        
        remainingBreakTime -= 1
        let minutes = Int(remainingBreakTime) / 60
        let seconds = Int(remainingBreakTime) % 60
        
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        countdownText?(formattedTime)
    }
}
