//
//  Alarm.swift
//  PomodoroApp
//
//  Created by Davis Goulet on 2020-05-04.
//  Copyright © 2020 Davis Goulet. All rights reserved.
//

import Foundation
import Cocoa

class Alarm {
    
    private var alarmTimer: Timer?
    private var isTimerRunning = false
    
    func startAlarm() {
        
        //If there is not a timer already running, start a new one.
        if !isTimerRunning {
            alarmTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
    }
    
    
    func stopAlarm() {
        if isTimerRunning {
            alarmTimer?.invalidate()
            alarmTimer = nil
            isTimerRunning = false
        }
    }
    
    @objc private func timerAction() {
        NSSound(named: "Purr")?.play()
    }
}
 
