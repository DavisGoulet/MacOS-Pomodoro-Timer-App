//
//  DataValues.swift
//  PomodoroApp
//
//  Created by Davis Goulet on 2020-05-02.
//  Copyright © 2020 Davis Goulet. All rights reserved.
//

import Foundation

enum SessionOptions {
    case Focus
    case ShortBreak
    case LongBreak
}

class DataValues {
    
    private var focusLength = 25
    private var shortBreakLength = 5
    private var longBreakLength = 15
    private var breaksBeforeLong = 4
    
    private var timerRunning = false
    private var timer: Timer?
    private var timerCallback: (() -> Void)?
    
    private let alarmTimer = Alarm()
 
    private var sessionType: SessionOptions?
    private var shortBreaksRemaining: Int?
    private var secondsRemaining: Int?
    
    func getFocusLength() -> Int {
        return focusLength
    }
    
    func getShortBreakLength() -> Int {
        return shortBreakLength
    }
    
    func getLongBreakLength() -> Int {
        return longBreakLength
    }
    
    func getBreaksBeforeLong() -> Int {
        return breaksBeforeLong
    }
    
    func setFocusLength(focusLength: Int) {
        if focusLength > 0 {
         self.focusLength = focusLength
        } else {
            self.focusLength = 1
        }
    }
    
    func setShortBreakLength(shortBreakLength: Int) {
        if shortBreakLength > 0 {
            self.shortBreakLength = shortBreakLength
        } else {
            self.shortBreakLength = 1
        }
    }
    
    func setLongBreakLength(longBreakLength: Int) {
        if longBreakLength > 0 {
            self.longBreakLength = longBreakLength
        } else {
            self.longBreakLength = 1
        }
    }
    
    func setBreaksBeforeLong(breaksBeforeLong: Int) {
        if breaksBeforeLong > 0 {
            self.breaksBeforeLong = breaksBeforeLong
        } else {
            self.breaksBeforeLong = 1
        }
    }
    
    func startTimer() {
        timerRunning = true
        sessionType = .Focus
        shortBreaksRemaining = breaksBeforeLong
        secondsRemaining = focusLength * 60
        
        //Call the initial timer action since it takes 1 second before the timers
        //first trigger.
        //timerAction()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timerRunning = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        switch sessionType! {
        case .Focus:
            secondsRemaining = focusLength * 60
        case .ShortBreak:
            secondsRemaining = shortBreakLength * 60
        case .LongBreak:
            secondsRemaining = longBreakLength * 60
        }
    }
    
    func isTimerRunning() -> Bool {
        return timerRunning
    }
    
    @objc func timerAction() {
        secondsRemaining! -= 1
        if secondsRemaining! <= 0 {
            startNotificationAlarm()
            secondsRemaining! = 0
        }
        
        if timerCallback != nil {
            timerCallback!()
        }
    }
    
    func goToNextSession() {
        
        //If the current session is Focus and there are short breaks remaining, then
        //go to a short break.
        if sessionType == .Focus && shortBreaksRemaining! > 0 {
            sessionType = .ShortBreak
            shortBreaksRemaining! -= 1
            secondsRemaining! = shortBreakLength * 60
        }
        //If the current session is Focus but there are no short breaks left, then go
        //to a long break and reset the short break counter.
        else if sessionType == .Focus && shortBreaksRemaining! <= 0 {
            sessionType = .LongBreak
            shortBreaksRemaining! = breaksBeforeLong
            secondsRemaining! = longBreakLength * 60
        }
        //If the current session is either a short break or long break, then go back
        //to a focus session.
        else {
            sessionType = .Focus
            secondsRemaining = focusLength * 60
        }
    }
    
    func setTimerCallback(timerCallback: @escaping () -> Void) {
        self.timerCallback = timerCallback
    }
    
    func removeTimerCallback() {
        self.timerCallback = nil
    }
    
    func startNotificationAlarm() {
        alarmTimer.startAlarm()
    }
    
    func stopNotificationAlarm() {
        alarmTimer.stopAlarm()
    }
    
    func getSecondsRemaining() -> Int {
        return secondsRemaining!
    }
    
    func getSessionType() -> String {
        switch sessionType! {
        case .Focus:
            return "Focus Session"
        case .ShortBreak:
            return "Short Break"
        case .LongBreak:
            return "Long Break"
        }
    }
    
    func getBreaksRemaining() -> Int {
        return shortBreaksRemaining!
    }
    
}
