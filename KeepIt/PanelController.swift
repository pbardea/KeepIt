//
//  PanelController.swift
//  KeepIt
//
//  Created by Paul Bardea on 2016-02-15.
//  Copyright © 2016 pbardea stdios. All rights reserved.
//

import Cocoa

protocol PanelControllerDelegate {
    func statusItemViewForPanelController(panelController: PanelController) -> StatusItemView?
}

class PanelController: NSWindowController, NSWindowDelegate {
    
    var delegate: PanelControllerDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let panel: NSPanel? = self.window as? NSPanel
        
        panel?.acceptsMouseMovedEvents = true
        panel?.level = Int(CGWindowLevelForKey(CGWindowLevelKey.PopUpMenuWindowLevelKey))
        panel?.opaque = false
        panel?.backgroundColor = NSColor.clearColor()
    }
    
    var hasActivePanel = false {
        didSet {
            if (hasActivePanel) {
                self.openPanel()
            } else {
                self.closePanel()
            }
        }
    }
    
    convenience init(delegate: PanelControllerDelegate) {
        self.init(windowNibName: "Panel")
        self.delegate = delegate
    }
    
    override init(window: NSWindow?) {
        super.init(window: window)
        self.delegate = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func statusRectForWindow(window: NSWindow) -> NSRect {
        let kStatusItemViewWidth: CGFloat = 24.0
        
        let screenRect = NSScreen.screens()!.first?.frame
        var statusRect = NSRect.zero
        
        if let statusItemView = self.delegate?.statusItemViewForPanelController(self) {
            statusRect = statusItemView.globalRect()
            statusRect.origin.y = NSMinY(statusRect) - NSHeight(statusRect)
        } else {
            statusRect.size = NSMakeSize(kStatusItemViewWidth, NSStatusBar.systemStatusBar().thickness)
            statusRect.origin.x = CGFloat(roundf(Float(NSWidth(screenRect!) - NSWidth(statusRect)/2)))
            statusRect.origin.y  = NSHeight(screenRect!) - NSHeight(statusRect) * 2
        }
        return statusRect
    }
    
    func openPanel() {
        let panel = self.window
        
        let kPanelWidth: CGFloat = 300
        let kPanelHeight = kPanelWidth
        
        let kArrowHeight: CGFloat = 20
        
        let screenRect = NSScreen.screens()!.first!.frame
        let statusRect = self.statusRectForWindow(panel!)
        
        if var panelRect = panel?.frame {
            panelRect.size.width = kPanelWidth
            panelRect.size.height = kPanelHeight
            panelRect.origin.x = CGFloat(roundf(Float(NSMidX(statusRect) - NSWidth(panelRect)/2)))
            panelRect.origin.y = NSMaxY(statusRect) - NSHeight(panelRect)
            
            if (NSMaxX(panelRect) > NSMaxX(screenRect) - kArrowHeight) {
                panelRect.origin.x -= NSMaxX(panelRect) - (NSMaxX(screenRect) - kArrowHeight)
            }
            
            NSApp.activateIgnoringOtherApps(false)
            panel?.alphaValue = 0
            panel?.setFrame(statusRect, display: true)
            panel?.makeKeyAndOrderFront(nil)
            
            NSAnimationContext.beginGrouping()
            NSAnimationContext.currentContext().duration = 0.15
            panel?.animator().setFrame(panelRect, display: true)
            panel?.animator().alphaValue = 1
            NSAnimationContext.endGrouping()
        }
        
    }
    
    func closePanel() {
        NSAnimationContext.beginGrouping()
        NSAnimationContext.currentContext().duration = 0.15
        self.window?.animator().alphaValue = 0
        NSAnimationContext.endGrouping()
    }
    
}
