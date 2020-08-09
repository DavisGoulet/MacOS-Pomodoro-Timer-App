//
//  TimerViewController.swift
//  PomodoroApp
//
//  Created by Davis Goulet on 2020-05-01.
//  Copyright © 2020 Davis Goulet. All rights reserved.
//

import Cocoa

class TimerViewController: NSViewController {

    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var continueButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var currentSessionLabel: NSTextField!
    @IBOutlet weak var shortBreaksRemainingLabel: NSTextField!
    
    private var parentController: WrapperViewController?
    private var dataValues: DataValues?
    
    override func viewDidAppear() {
        super.viewDidAppear()
        updateView()
        dataValues?.setTimerCallback {
            self.updateView()
        }
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        dataValues?.removeTimerCallback()
    }
    
    func initVariables(parentController: WrapperViewController, dataValues: DataValues) {
        self.parentController = parentController
        self.dataValues = dataValues
    }
    
    func updateView() {
        
        let secondsLeftOnTimer = dataValues!.getSecondsRemaining()
        
        let secondsLeft = secondsLeftOnTimer % 60
        let minutesLeft = (secondsLeftOnTimer / 60)
        
        timeLabel.stringValue = String(format: "%02d", minutesLeft) + ":" + String(format: "%02d", secondsLeft)
        
        currentSessionLabel.stringValue = dataValues!.getSessionType()
        shortBreaksRemainingLabel.stringValue = String(dataValues!.getBreaksRemaining()) + " Short Breaks Remaining"
    }
    
    @IBAction func stopButtonListener(_ sender: Any) {
        dataValues!.stopNotificationAlarm()
        dataValues?.stopTimer()
        self.parentController?.updateChildView(goto: .option)
    }
    
    @IBAction func continueButtonListener(_ sender: Any) {
        dataValues!.stopNotificationAlarm()
        dataValues!.goToNextSession()
        updateView()
    }
    
    
    @IBAction func resetButtonListener(_ sender: Any) {
        dataValues!.stopNotificationAlarm()
        dataValues!.resetTimer()
        updateView()
    }
}
