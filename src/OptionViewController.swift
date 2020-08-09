//
//  OptionViewController.swift
//  PomodoroApp
//
//  Created by Davis Goulet on 2020-05-01.
//  Copyright © 2020 Davis Goulet. All rights reserved.
//

import Cocoa

class OptionViewController: NSViewController {

    @IBOutlet weak var focusLengthLabel: NSTextField!
    @IBOutlet weak var shortBreakLengthLabel: NSTextField!
    @IBOutlet weak var longBreakLengthLabel: NSTextField!
    @IBOutlet weak var sessionsBeforeBreakLabel: NSTextField!
    
    @IBOutlet weak var incFocusLengthButton: NSButton!
    @IBOutlet weak var decFocusLengthButton: NSButton!
    
    @IBOutlet weak var incShortBreakButton: NSButton!
    @IBOutlet weak var decShortBreakButton: NSButton!
    
    @IBOutlet weak var incLongBreakButton: NSButton!
    @IBOutlet weak var decLongBreakButton: NSButton!
    
    @IBOutlet weak var incSessionBeforeBreakButton: NSButton!
    @IBOutlet weak var decSessionsBeforeBreakButton: NSLayoutConstraint!
    
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!
    
    private var parentController: WrapperViewController?
    private var dataValues: DataValues?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func initVariables(parentController: WrapperViewController, dataValues: DataValues) {
        self.parentController = parentController
        self.dataValues = dataValues
    }
    
    func updateView() {
        
        focusLengthLabel.stringValue = String(dataValues!.getFocusLength()) + " minutes"
        focusLengthLabel.sizeToFit()
        shortBreakLengthLabel.stringValue = String(dataValues!.getShortBreakLength()) + " minutes"
        shortBreakLengthLabel.sizeToFit()
        longBreakLengthLabel.stringValue = String(dataValues!.getLongBreakLength()) + " minutes"
        longBreakLengthLabel.sizeToFit()
        sessionsBeforeBreakLabel.stringValue = String(dataValues!.getBreaksBeforeLong()) + " minutes"
        sessionsBeforeBreakLabel.sizeToFit()
    }
    
    @IBAction func startTimerListener(_ sender: Any) {
        self.parentController?.updateChildView(goto: .timer)
        dataValues?.startTimer()
    }
    @IBAction func quitTimerListener(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func incFocusLength(_ sender: Any) {
        dataValues?.setFocusLength(focusLength: (dataValues?.getFocusLength())! + 1)
        updateView()
    }
    
    @IBAction func decFocusLength(_ sender: Any) {
        dataValues?.setFocusLength(focusLength: (dataValues?.getFocusLength())! - 1)
        updateView()
    }
    
    @IBAction func incShortBreakLength(_ sender: Any) {
        dataValues?.setShortBreakLength(shortBreakLength: (dataValues?.getShortBreakLength())! + 1)
        updateView()
    }
    
    @IBAction func decShortBreakLength(_ sender: Any) {
        dataValues?.setShortBreakLength(shortBreakLength: (dataValues?.getShortBreakLength())! - 1)
        updateView()
    }
    
    @IBAction func incLongBreakLength(_ sender: Any) {
        dataValues?.setLongBreakLength(longBreakLength: (dataValues?.getLongBreakLength())! + 1)
        updateView()
    }
    
    @IBAction func decLongBreakLength(_ sender: Any) {
        dataValues?.setLongBreakLength(longBreakLength: (dataValues?.getLongBreakLength())! - 1)
        updateView()
    }
    
    @IBAction func incSessionsBeforeLongBreak(_ sender: Any) {
        dataValues?.setBreaksBeforeLong(breaksBeforeLong: (dataValues?.getBreaksBeforeLong())! + 1)
        updateView()
    }
    
    @IBAction func decSessionsBeforeLongBreak(_ sender: Any) {
        dataValues?.setBreaksBeforeLong(breaksBeforeLong: (dataValues?.getBreaksBeforeLong())! - 1)
        updateView()
    }
    
    
}
