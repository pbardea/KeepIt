//
//  StatusMenuController.swift
//  KeepIt
//
//  Created by Paul Bardea on 2016-02-14.
//  Copyright © 2016 pbardea stdios. All rights reserved.
//

import Cocoa
import WebKit

class StatusMenuController: NSObject, PanelControllerDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    let popover = NSPopover()
    var popoverIsOpen = false
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(20)
    var statusItemView: StatusItemView?
    
    let panelController = PanelController()
    
    override func awakeFromNib() {
        let icon = NSImage(named: "Todo")
        statusItem.menu = statusMenu
        icon?.size = NSSize(width: 15, height: 15)
        icon?.template = true // best for dark mode
        statusItem.image = icon
        statusItem.button?.target = self
        statusItem.button?.action = Selector("togglePopover")
        
        self.statusItemView = StatusItemView(statusItem: self.statusItem)
        
    }
    
    func togglePopover() {
        self.panelController.hasActivePanel = !self.panelController.hasActivePanel
    }
    
    func statusItemViewForPanelController(panelController: PanelController) -> StatusItemView? {
        return self.statusItemView
    }
}
