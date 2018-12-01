//
//  ToDoItem.swift
//  ToDo
//
//  Created by Levi Linchenko on 01/12/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation

class ToDoItem : Codable, Equatable {
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    let uid = UUID().uuidString
    var title: String
    var isComplete: Bool
    let timeStamp: Date
    var description: String?
    
    init(title: String) {
        self.title = title
        self.isComplete = false
        self.timeStamp = Date()
    }
    
    
}
