//
//  SnackUser.swift
//  Snacktacular
//
//  Created by Bridget Falkenhayn on 4/24/22.
//

import Foundation
import Firebase

class User {
    var email: String
    var displayName: String
    var photoURL: String
    var userSince: Date
    var documentID: String
    var starSign: String
    
    
    var dictionary: [String: Any] {
        let timeIntervalDate = userSince.timeIntervalSince1970
        return ["email": email, "displayName": displayName, "photoURL": photoURL, "userSince": timeIntervalDate, "documentID": documentID, "starSign": starSign]
        
    }
    init(email: String, displayName: String, photoURL: String, userSince: Date, documentID: String, starSign: String) {
        self.email = email
        self.displayName = displayName
        self.photoURL = photoURL
        self.userSince = userSince
        self.documentID = documentID
        self.starSign = starSign
    }
    
    convenience init(user: FirebaseAuth.User, starSign: String) {
        let email = user.email ?? ""
        let displayName =  user.displayName ?? ""
        let photoURL = user.photoURL != nil ? "(user.photoURL!)" : ""
        let starSign = starSign ?? ""
        self.init(email: email, displayName: displayName, photoURL: photoURL, userSince: Date(), documentID: user.uid, starSign: starSign)
        
    }
    
    
    
    
    
    convenience init(dicitonary: [String: Any]) {
        let email = dicitonary["email"] as! String? ?? ""
        let displayName = dicitonary["displayName"] as! String? ?? ""
        let photoURL = dicitonary["photoURL"] as! String? ?? ""
        let timeIntervalDate = dicitonary["userSince"] as! TimeInterval? ?? TimeInterval()
        let userSince = Date(timeIntervalSince1970: timeIntervalDate)
        let starSign = dicitonary["starSign"] as! String? ?? ""
        self.init(email: email, displayName: displayName, photoURL: photoURL, userSince: userSince, documentID: "", starSign: starSign)
        
    } 
    
    func saveIfNewUser(completion: @escaping (Bool) -> ()){
        let db = Firestore.firestore()

        
        
        let dataToSave: [String: Any] = self.dictionary
        if self.documentID == "" {
            //            Create a new document
            var ref:DocumentReference? = nil
            ref = db.collection("users").addDocument(data: dataToSave) {
                (error) in
                guard error == nil else {
                    print("Error: could not save data because \(error?.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("Added document: \(self.documentID)")
                return  completion(true)
            }
        } else {
            // else save to the exisiting documentID
            let ref = db.collection("users").document(self.documentID)
            ref.setData(dataToSave) { error in
                guard error == nil else {
                    print("Error: could not update data because \(error?.localizedDescription)")
                    return completion(false)
                    
                }
                 return completion(true)
            }
        }
        
    }
    
    
    
//    func saveIfNewUser(completion: @escaping (Bool) -> ()) {
//        let db = Firestore.firestore()
//
//        let userRef = db.collection("users").document(documentID)
//
//        userRef.getDocument { document, error in
//            guard error == nil else {
//                return completion(false)
//            }
//            guard document?.exists == false else {
//                return completion(true)
//            }
//            let dataToSave: [String: Any] = self.dictionary
//            db.collection("users").document(self.documentID).setData(dataToSave) {
//                (error) in
//                guard error == nil else {
//                    return completion(false)
//                }
//                return completion(true)
//            }
//        }
//    }
    
    
}
