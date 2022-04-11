//
//  Agenda.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/8/22.
//

import Foundation

struct Agenda: Codable {
    var time: Date
    var activity: String
    var notes: String
    var reminderSet: Bool
    var notificationID: String
    var completed: Bool
    
   
}
