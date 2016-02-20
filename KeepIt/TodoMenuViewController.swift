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
    var completed: Bool = false
    var dueDate: NSDate = NSDate()
    
    init(title: String) {
        self.title = title
    }
}

class TodoMenuViewController: NSViewController {
    
    var directoryItems: [Todo]? = [Todo(title: "Item 1"), Todo(title: "Item 2")]
    
    let todoList: NSTableView = NSTableView()
    let titleColumn = NSTableColumn(identifier: "title")
    let completedColumn = NSTableColumn(identifier: "completed")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoList.frame = self.view.bounds
        
        todoList.addTableColumn(completedColumn)
        todoList.addTableColumn(titleColumn)
        todoList.backgroundColor = NSColor(colorLiteralRed: 1.0, green: 0, blue: 0, alpha: 0.5)

        // Do view setup here.
        todoList.setDelegate(self)
        todoList.setDataSource(self)
        
        self.view.addSubview(todoList)
    }
    
}

extension TodoMenuViewController: NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String? = nil
        var cellIdentifier: String = ""
        
        guard let todo = directoryItems?[row] else {
            return nil
        }
        
        if tableColumn == tableView.tableColumns[0] {
            text = todo.title as String
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = todo.dueDate.description
            cellIdentifier = "DateCellId"
        }
        
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            if let textE = text {
                cell.textField?.stringValue = textE
                cell.backgroundStyle = .Light
            }
            return cell
        }
        return nil
    }
}

extension TodoMenuViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return directoryItems?.count ?? 0
    }
}
