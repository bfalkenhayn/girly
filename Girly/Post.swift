//
//  Post.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/24/22.
//

import Foundation
import Firebase
import FirebaseFirestore

class Post: NSObject {
    var content: String
    var prompt: String
    var timePosted: Date
    var numberOfLikes: Int
    var numberOfComments: Int
    var documentID: String
    var postingUserID: String
    
    var dictionary: [String: Any] {
        let timeIntervalDate = timePosted.timeIntervalSince1970
        return  ["content": content, "prompt": prompt, "timePosted": timeIntervalDate, "numberOfLikes": numberOfLikes, "numberOfComments": numberOfComments, "postingUserID": postingUserID ]
    }
    
    init(content: String, prompt:String, timePosted: Date, numberOfLikes: Int, numberOfComments: Int, documentID: String, postingUserID: String) {
        self.content = content
        self.prompt = prompt
        self.timePosted = timePosted
        self.numberOfComments = numberOfComments
        self.numberOfLikes = numberOfLikes
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience override init() {
        self.init(content: "", prompt: "", timePosted: Date(), numberOfLikes: 0, numberOfComments: 0, documentID: "", postingUserID:"")
    }
    
    convenience init(dictionary: [String: Any]) {
        let content = dictionary["content"] as! String? ?? ""
        let prompt = dictionary["prompt"] as! String? ?? ""
        let timeIntervalDate = dictionary["timePosted"] as! TimeInterval? ?? TimeInterval()
        let numberOfLikes = dictionary["numberOfLikes"] as! Int? ?? 0
        let numberOfComments = dictionary["numberOfComments"] as! Int? ?? 0
        let postingUserId = dictionary["postingUserId"] as! String? ?? ""
        let documentID = dictionary["documentID"] as! String? ?? ""
        let timePosted = Date(timeIntervalSince1970: timeIntervalDate)
        self.init(content: content, prompt: prompt, timePosted: timePosted, numberOfLikes: numberOfLikes, numberOfComments: numberOfComments, documentID: documentID, postingUserID:postingUserId)
    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()

        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("Error: could not save data because we do not have a valid postinguserid")
            return completion(false)
        }
        self.postingUserID = postingUserID
        let dataToSave: [String: Any] = self.dictionary
        if self.documentID == "" {
            //            Create a new document
            var ref:DocumentReference? = nil
            ref = db.collection("posts").addDocument(data: dataToSave) {
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
            let ref = db.collection("posts").document(self.documentID)
            ref.setData(dataToSave) { error in
                guard error == nil else {
                    print("Error: could not update data because \(error?.localizedDescription)")
                    return completion(false)
                    
                }
                 return completion(true)
            }
        }
        
    }
    
}
