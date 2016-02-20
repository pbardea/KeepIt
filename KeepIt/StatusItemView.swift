//
//  StatusItemView.swift
//  KeepIt
//
//  Created by Paul Bardea on 2016-02-15.
//  Copyright © 2016 pbardea stdios. All rights reserved.
//

import Cocoa

class StatusItemView: NSView {
    
    var statusItem: NSStatusItem!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    init(statusItem: NSStatusItem) {
        let itemWidth = statusItem.length
        let itemHeight = NSStatusBar.systemStatusBar().thickness
        
        let itemRect = NSMakeRect(0, 0, itemWidth, itemHeight)
        super.init(frame: itemRect)
        
        self.statusItem = statusItem
        self.statusItem.view = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func globalRect() -> NSRect {
        let frame = self.frame
        return self.window!.convertRectToScreen(frame)
    }
    
}
