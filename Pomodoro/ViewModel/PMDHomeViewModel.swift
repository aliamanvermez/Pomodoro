//
//  PMDHomeViewModel.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 12.08.2023.
//

import Foundation
class PMDHomeViewModel {
      private var timer: Timer?
      private var remainingTime: TimeInterval = 25 * 60 // 25 dakika
      
      var countdownText: ((String) -> Void)?

      init() {
          timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
      }

      @objc private func updateCountdown() {
          guard remainingTime > 0 else {
              timer?.invalidate()
              return
          }
          
          remainingTime -= 1
          let minutes = Int(remainingTime) / 60
          let seconds = Int(remainingTime) % 60
          
          let formattedTime = String(format: "%02d:%02d", minutes, seconds)
          countdownText?(formattedTime)
      }
}
