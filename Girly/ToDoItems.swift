//
//  ToDoItems.swift
//  ToDo List
//
//  Created by Bridget Falkenhayn on 2/27/22.
//

import Foundation
import UserNotifications

class ToDoItems {
    var itemsArray: [ToDoItem] = []
    
    func loadData(completed: @escaping () -> ()) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
           itemsArray = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
           }
        catch {print("error in loading data")
    }
        print("load data")
        completed()
        
        
}
      func saveData() {
          print("save data functions")
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
          let data = try? jsonEncoder.encode(itemsArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {print("error: could not save data")}
        setNotifications()
    }
    
     func setNotifications() {
        guard itemsArray.count > 0 else {
             return
         }
         UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
         
        for index in 0..<itemsArray.count {
             if itemsArray[index].reminderSet {
                 let toDoItem = itemsArray[index]
                 itemsArray[index].notificationID = LocalNotificationsManager.setCalendarNotifications(title: toDoItem.name, subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
             }
         }
     }
}
// these were cut out and it's a difference between my code and the video
//   let toDoItem = toDoItems.first!
//let notificationID = setCalendarNotifications(title: toDoItem.name, subtitle: "SUBTITLE Would GO Here", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
