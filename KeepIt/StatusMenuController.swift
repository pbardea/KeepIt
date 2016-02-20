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
    
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(20)
    
    override func awakeFromNib() {
        let icon = NSImage(named: "Todo")
        icon?.size = NSSize(width: 15, height: 15)
        icon?.template = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
    }    

}
