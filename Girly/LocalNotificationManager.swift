//
//  LocalNotificationManager.swift
//  ToDo List
//
//  Created by Bridget Falkenhayn on 2/27/22.
//


import UserNotifications
import UIKit

struct LocalNotificationsManager {
    
    static func authorizeLocalNotifications (viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notification")
            } else {
                DispatchQueue.main.sync {
                    print("User has denied notifications")
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To receive alerts for reminders, open the Settings app, selected To Do List > Notifications > Allow Notifications")
                }
                
            }
        }
    }
    
    static func isAuthorized (completed: @escaping (Bool) -> ()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                completed(true)
                return
            }
            if granted {
                print("Notification")
                completed(true)
            } else {
                DispatchQueue.main.sync {
                    completed(false)
                }
                
            }
        }
    }
    
    
   static  func setCalendarNotifications(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
            else {print("Notification Schedulued \(notificationID), title, \(content.title)")}
        }
        return notificationID
    }
    
   
}
