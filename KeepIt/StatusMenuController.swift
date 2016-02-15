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
    
    let webView = WebView(frame: NSRect(x: 0, y: 0, width: 400, height: 300))
    
    override func awakeFromNib() {
        let icon = NSImage(named: "Todo")
        icon?.size = NSSize(width: 15, height: 15)
        icon?.template = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        webView.mainFrameURL = "https://keep.google.com"
        
        let webItem = NSMenuItem(title: "testing", action: "reloadPressed:", keyEquivalent: "")
        webItem.view = webView
       
        statusItem.menu?.addItem(webItem)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation) {
        print("Finished navigating to url")
    }

}
