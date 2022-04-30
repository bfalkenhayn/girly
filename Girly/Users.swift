//
//  SnackUsers.swift
//  Snacktacular
//
//  Created by Bridget Falkenhayn on 4/24/22.
//

import Foundation
import Firebase

class Users {
    var userArray: [User] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("users").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("eror in adding snapshot listener")
                return completed()
            }
            self.userArray = []
            for document in querySnapshot!.documents {
                let users = User(dicitonary: document.data())
                users.documentID = document.documentID
                self.userArray.append(users)
                
            }
            completed()
        }
    }
    
}
