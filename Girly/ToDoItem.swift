//
//  ToDoItem.swift
//  ToDo List
//
//  Created by Bridget Falkenhayn on 2/20/22.
//

import Foundation


struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
    var reminderSet: Bool
    var notificationID: String?
    var completed: Bool 
}




