//
//  AgendaItems.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/8/22.
//

import Foundation
import UserNotifications

class AgendaItems {
    var agendaArray: [Agenda] = []
    
    func loadData(completed: @escaping () -> ()) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
           agendaArray = try jsonDecoder.decode(Array<Agenda>.self, from: data)
            agendaArray.sort(by: {$0.time < $1.time})
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
          let data = try? jsonEncoder.encode(agendaArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
            agendaArray.sort(by: {$0.time < $1.time})
        } catch {print("error: could not save data")}
        setNotifications()
    }
    
     func setNotifications() {
        guard agendaArray.count > 0 else {
             return
         }
         UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
         
        for index in 0..<agendaArray.count {
             if agendaArray[index].reminderSet {
                 let toDoItem = agendaArray[index]
                 agendaArray[index].notificationID = LocalNotificationsManager.setCalendarNotifications(title: toDoItem.activity, subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.time)
             }
         }
         
     }
}
