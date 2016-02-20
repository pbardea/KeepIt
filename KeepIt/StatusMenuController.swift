//
//  StatusMenuController.swift
//  KeepIt
//
//  Created by Paul Bardea on 2016-02-14.
//  Copyright © 2016 pbardea stdios. All rights reserved.
//

import Cocoa
import WebKit

class StatusMenuController: NSObject, WKNavigationDelegate {
    
    let popover = NSPopover()
    
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(20)
    
    override func awakeFromNib() {
        if let button = statusItem.button {
            button.image = NSImage(named: "Todo")
            button.image?.size = NSSize(width: 15, height: 15)
            button.image?.template = true // best for dark mode
        }
        
        statusItem.menu = statusMenu
        statusItem.target = self
        statusItem.action = Selector("togglePopover:")
        
        popover.contentViewController = TodoMenuViewController(nibName: "TodoMenuViewController", bundle: nil)
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

}
