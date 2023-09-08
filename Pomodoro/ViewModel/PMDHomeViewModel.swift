//
//  PMDHomeViewModel.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 12.08.2023.
//

import Foundation
import AVFoundation
class PMDHomeViewModel {
    var timer : Timer?
    var pomodoroRemainingTime : TimeInterval = 25 * 60
    var chosenPomodoroRemainingTime : TimeInterval?
    var pomodoroRemainingBreakTime : TimeInterval = 5 * 60
    
    var isBreak : Bool = false
    
    var pomodoroTimeText : ((String)-> Void)?
    var pomodoroBreakTimeText : ((String)->Void)?
    
    var pomodoroAlertTrigger : (() -> Void)?
    var pomodoroBreakAlertTrigger : (()->Void)?
            
    func startPomodoroTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func startPomodoroBreakTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    func stopPomodoroTime(){
        timer?.invalidate()
    }
    
    func resetPomodoroTime(){
        if  chosenPomodoroRemainingTime != nil {
            pomodoroRemainingTime = chosenPomodoroRemainingTime!
        } else {
            pomodoroRemainingTime = 25 * 60
        }
        pomodoroTimeText?(String(format: "%02d:%02d", Int(pomodoroRemainingTime) / 60, Int(pomodoroRemainingTime) % 60))
    }
    
    func set50MinutesPomodoroTimeBreak(){
        pomodoroRemainingBreakTime = 10 * 60
    }
    
    @objc func updateTimer(){
            if pomodoroRemainingTime > 0 {
                pomodoroRemainingTime -= 1
                pomodoroTimeText?(String(format: "%02d:%02d", Int(pomodoroRemainingTime) / 60, Int(pomodoroRemainingTime) % 60))
                print("Pomodoro Work Time: \(pomodoroRemainingTime)")
            }
            else{
                print("çalışma zamanı bitiş")
                timer?.invalidate()
                pomodoroAlertTrigger?()
                pomodoroBitisSesEfektiCalistir()
            }
    }
    
    @objc func updateBreakTimer(){
        if pomodoroRemainingBreakTime > 0 {
            pomodoroRemainingBreakTime -= 1
            pomodoroBreakTimeText?(String(format: "%02d:%02d", Int(pomodoroRemainingBreakTime) / 60, Int(pomodoroRemainingBreakTime) % 60))
            print("Pomodoro Break Time: \(pomodoroRemainingBreakTime)")
        }
        else{
            timer?.invalidate()
            pomodoroBreakAlertTrigger?()
        }
    }
    
    
    func pomodoroBitisSesEfektiCalistir(){
        do {
            let url = try Bundle.main.url(forResource: "end_of_pomo_sound", withExtension: "mp3")
            let player = try! AVAudioPlayer(contentsOf: url!)
            player.play()

        } catch {
            print("error")
        }
    }
    
    
}

