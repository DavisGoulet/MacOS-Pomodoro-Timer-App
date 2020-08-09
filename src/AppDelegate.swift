//
//  AppDelegate.swift
//  PomodoroApp
//
//  Created by Davis Goulet on 2020-04-10.
//  Copyright © 2020 Davis Goulet. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    let popoverView = NSPopover()
    
    let dataValues = DataValues()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let icon = NSImage(imageLiteralResourceName:"icon")
        icon.isTemplate = true
        
        statusItem.button?.image = icon;
        //statusItem.button?.cell.highlightsBy = true;
        
        //statusItem.button?.title = "Ⓐ"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        //When stopping the application, make sure all timers have stopped.
        dataValues.stopNotificationAlarm()
        dataValues.stopTimer()
    }
    
    @objc func showSettings() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "WrapperScreen") as? WrapperViewController else {fatalError("Unable to find WrapperViewController in the storyboard.")}
        
        vc.initVaraibles(dataValues: dataValues)
        
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
    }


}

