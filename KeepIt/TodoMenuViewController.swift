//
//  TodoMenuViewController.swift
//  KeepIt
//
//  Created by Paul Bardea on 2016-02-19.
//  Copyright © 2016 pbardea stdios. All rights reserved.
//

import Cocoa

class Todo {
    var title: String
    var completed = false
    var dueDate: NSDate?
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, dueDate: NSDate) {
        self.title = title
        self.dueDate = dueDate
    }
}

class TodoMenuViewController: NSViewController {
    
    var todoList = [Todo(title: "Thing 1"), Todo(title: "Thing 2")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

// MARK: - NSTableViewDataSource
extension TodoMenuViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.todoList.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        if tableColumn!.identifier == "todoListColumn" {
            let todoItem = self.todoList[row]
            cellView.backgroundStyle = NSBackgroundStyle.Light
            return cellView
        }
        
        return cellView
    }
}

// MARK: - NSTableViewDelegate
extension TodoMenuViewController: NSTableViewDelegate {
}