//
//  PMDHomeViewModel.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 12.08.2023.
//

import Foundation
class PMDHomeViewModel {
    var timer : Timer?
    var pomodoroRemainingTime : TimeInterval = 25 * 60
    var pomodoroRemainingBreakTime : TimeInterval = 10
    var isBreak : Bool = false
    
    var pomodoroTimeText : ((String)-> Void)?
    var pomodoroBreakTimeText : ((String)->Void)?
    
    var pomodoroAlertTetikle : (() -> Void)?
    var pomodoroBreakAlertTetikle : (()->Void)?
        
    func startPomodoroTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func startPomodoroBreakTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    func stopPomodoroTime(){
        timer?.invalidate()
    }
    
    @objc func updateTimer(){
            if pomodoroRemainingTime > 0 {
                pomodoroRemainingTime -= 1
                pomodoroTimeText?(String(format: "%02d:%02d", Int(pomodoroRemainingTime) / 60, Int(pomodoroRemainingTime) % 60))
                print("Pomodoro Work Time: \(pomodoroRemainingTime)")
            }
            else{
                pomodoroRemainingTime = 5
                timer?.invalidate()
                pomodoroAlertTetikle?()
            }
    }
    
    @objc func updateBreakTimer(){
        if pomodoroRemainingBreakTime > 0 {
            pomodoroRemainingBreakTime -= 1
            pomodoroBreakTimeText?("\(pomodoroRemainingBreakTime)")
            print("Pomodoro Break Time: \(pomodoroRemainingBreakTime)")
        }
        else{
            timer?.invalidate()
            pomodoroBreakAlertTetikle?()
        }
    
    }
}





















//    private var mainTimer: Timer?
//    private var breakTimer: Timer?
//    private var remainingTime: TimeInterval = 5 // 25 dakika
//    private var remainingBreakTime : TimeInterval = 3 //5 dakika
//    private var isOnBreak = false
//
//    var countdownText: ((String) -> Void)?
//    var timerCompleted : (() -> Void)?
//    var breakCompleted: (() -> Void)?
//
//    init() {
//        startMainTimer()
//    }
//
//
//    func startMainTimer() {
//        mainTimer?.invalidate()
//        mainTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMainCountdown), userInfo: nil, repeats: true)
//    }
//
//
//    func startBreakTimer() {
//        breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakCountdown), userInfo: nil, repeats: true)
//    }
//
//    @objc private func updateMainCountdown() {
//        guard remainingTime > 0 else {
//            mainTimer?.invalidate()
//            isOnBreak = true
//            startBreakTimer()
//            timerCompleted?()
//            return
//        }
//
//        remainingTime -= 1
//        let minutes = Int(remainingTime) / 60
//        let seconds = Int(remainingTime) % 60
//
//        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
//        countdownText?(formattedTime)
//    }
//
//    @objc private func updateBreakCountdown() {
//        guard remainingBreakTime > 0 else {
//            breakTimer?.invalidate()
//            breakCompleted?()
//            return
//        }
//
//        remainingBreakTime -= 1
//        let minutes = Int(remainingBreakTime) / 60
//        let seconds = Int(remainingBreakTime) % 60
//
//        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
//        countdownText?(formattedTime)
//    }
