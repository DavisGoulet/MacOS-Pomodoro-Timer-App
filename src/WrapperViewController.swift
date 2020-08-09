//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Davis Goulet on 2020-04-10.
//  Copyright © 2020 Davis Goulet. All rights reserved.
//

import Cocoa

class WrapperViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var containerView: NSView!

    var optionController: OptionViewController
    
    var timerController: TimerViewController
    
    var currentScreen: View? = nil
    
    var dataValues: DataValues?
    
    required init?(coder: NSCoder) {
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        self.optionController = storyboard.instantiateController(withIdentifier: "OptionScreen") as! OptionViewController
        
        self.timerController = storyboard.instantiateController(withIdentifier: "TimerScreen") as! TimerViewController
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (dataValues?.isTimerRunning())! {
            updateChildView(goto: .timer)
        } else {
            updateChildView(goto: .option)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func initVaraibles(dataValues: DataValues) {
        self.dataValues = dataValues
        optionController.initVariables(parentController: self, dataValues: dataValues)
        addChild(optionController)
        timerController.initVariables(parentController: self, dataValues: dataValues)
        addChild(timerController)
    }
    
    private func addView(controller: NSViewController) {
        //Display the given controller on the container view.
        containerView.addSubview(controller.view)
        
        //Get the dimensions of the view that is being added.
        let viewWidth = controller.view.bounds.width
        let viewHeight = controller.view.bounds.height
        
        //Resize the popover to the new dimensions.
        let appDelegate : AppDelegate = NSApplication.shared.delegate as! AppDelegate
        //Stop the anmiate from occuring during the resize.
        appDelegate.popoverView.animates = false
        appDelegate.popoverView.contentSize = NSSize(width: viewWidth, height: viewHeight)
        //Set the animate back on. Not doing this removes the animate played when it is first opened.
        appDelegate.popoverView.animates = true
    }
    
    private func removeView(controller: NSViewController?) {
        
        //If the controller is not nil, then remove it from the view.
        if controller != nil {
            controller?.view.removeFromSuperview()
        }
    }
    
    func updateChildView(goto viewOption: View) {
        switch viewOption {
            case .timer:
                currentScreen = .timer
                removeView(controller: optionController)
                addView(controller: timerController)
            case .option:
                currentScreen = .option
                removeView(controller: timerController)
                addView(controller: optionController)
        }
    }
    
}

