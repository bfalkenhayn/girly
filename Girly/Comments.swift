//
//  Reviews.swift
//  Snacktacular
//
//  Created by Bridget Falkenhayn on 4/8/22.
//

import Foundation
import Firebase
class Comments {
    var commentsArray: [Comment] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(post: Post, completed: @escaping () -> ()) {
        guard post.documentID != "" else {
            return
        }
        db.collection("posts").document(post.documentID).collection("comments").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("eror in adding snapshot listener")
                return completed()
            }
            self.commentsArray = []
            for document in querySnapshot!.documents {
                let comment = Comment(dictionary: document.data())
                comment.documentID = document.documentID
                self.commentsArray.append(comment)
                
            }
            completed()
        }
    }
    
}
