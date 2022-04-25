//
//  NewPostViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/24/22.
//

import UIKit

class NewPostViewController: UIViewController {
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var promptLabel: UILabel!
    
 
    var post:Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        post = Post()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateFromUserInterface(){
        post.content = contentTextView.text!
        if promptLabel.text == "Roll for a random prompt 🎲" {
            post.prompt = "unprompted"
        } else {
            post.prompt = promptLabel.text!
        }
        
        
    }
    
    @IBAction func promptLabelPressed(_ sender: Any) {
        
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUserInterface()
        post.timePosted = Date()
        post.numberOfLikes = 0
        post.numberOfComments = 0
        post.postingUserID = ""
        post.documentID = ""
        post.saveData { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.oneButtonAlert(title: "Save Failed", message: "For some reason Data would not save to the Cloud")
            }
        }
    }

}
