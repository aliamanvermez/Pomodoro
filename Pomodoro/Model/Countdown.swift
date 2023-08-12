//
//  Timer.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 11.08.2023.
//

import Foundation
class Countdown {
    var remainingTime : TimeInterval = 25 * 60
    var isWorking : Bool = true
    private var timer : Timer?
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            [weak self] timer in
            guard let self = self else {
            timer.invalidate()
            return
            }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                print(self.remainingTime)
            } else {
                self.isWorking.toggle()
                self.remainingTime = self.isWorking ? 25 * 60 : 5 * 60
            }
        
        })
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
}
