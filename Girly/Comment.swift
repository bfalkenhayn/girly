//
//  Review.swift
//  Snacktacular
//
//  Created by Bridget Falkenhayn on 4/8/22.
//

import Foundation
import Firebase
import FirebaseFirestore


class Comment: NSObject  {
    var content: String
    var reviewUserID: String
    var date: Date
    var documentID: String
    

    
    
    var dictionary: [String: Any] {
        let timeIntervalDate = date.timeIntervalSince1970
        return ["content": content, "reviewUserID": reviewUserID, "date": timeIntervalDate]
    }
    
    //converting from date to time interval
    
    
    
    init(content: String, reviewUserID:String, date:Date, documentID:String) {
        self.content = content
        self.date = date
        self.reviewUserID = reviewUserID
        self.documentID = documentID
        
        
    }
    
    convenience override init() {
        let reviewUserID = Auth.auth().currentUser?.uid ?? ""
        let reviewUserEmail = Auth.auth().currentUser?.email ?? ""
        self.init(content: "", reviewUserID: reviewUserID, date: Date(), documentID: "")
        
    }
    convenience init(dictionary: [String: Any]) {
        let content = dictionary["content"] as! String? ?? ""
        let timeIntervalDate = dictionary["date"] as! TimeInterval? ?? TimeInterval()
        let reviewUserID = dictionary["reviewUserID"] as! String? ?? ""
        let documentId = dictionary["documentId"] as! String? ?? ""
        let reviewUserEmail = dictionary["reviewUserEmail"] as! String? ?? ""
        let date = Date(timeIntervalSince1970: timeIntervalDate)
        self.init(content: content, reviewUserID: reviewUserID, date: date , documentID: documentId)
    }
    
    func saveData(post: Post, completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()

        
          let dataToSave: [String: Any] = self.dictionary
        if self.documentID == "" {
            //            Create a new document
            var ref:DocumentReference? = nil
            ref = db.collection("posts").document(post.documentID).collection("comments").addDocument(data: dataToSave) {
                (error) in
                guard error == nil else {
                    print("Error: could not save data because \(error?.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("Added document: \(self.documentID)")
               completion(true)
            }
        } else {
            // else save to the exisiting documentID
            let ref = db.collection("posts").document(post.documentID).collection("comments").document(self.documentID)
            ref.setData(dataToSave) { error in
                guard error == nil else {
                    print("Error: could not update data because \(error?.localizedDescription)")
                    return completion(false)
                    
                }
               completion(true)
            }
        }
        
    }
    
    func deleteData(post: Post, completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        db.collection("posts").document(post.documentID).collection("comments").document(documentID).delete() {(error) in
            if let error = error {
                print("ERROR IN deleting review Document ID \(self.documentID)")
                completion(false)
            } else {
//                spot.updateAverageRating {
//                    completion(true)
//                }
               
            }
        }
    }
    
    
    
}
