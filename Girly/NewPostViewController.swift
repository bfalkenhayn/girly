//
//  NewPostViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/24/22.
//

import UIKit

class NewPostViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var contentTextView: UITextView!
   
    
    @IBOutlet weak var promptButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var contentFromJournal = ""
    var promptFromJournal = ""
    var prompts: Prompts!
    var post:Post!
    @IBOutlet weak var promptLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        post = Post()
        prompts = Prompts()
        contentTextView.text = contentFromJournal
        if promptFromJournal == "" {
            promptLabel.text = promptFromJournal
        } else {
            promptLabel.text = promptFromJournal
            promptButton.isHidden = true
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateFromUserInterface(){
        post.content = contentTextView.text!
        if promptLabel.text  == "" {
            post.prompt = "unprompted"
        } else {
            post.prompt = promptLabel.text! ?? "unprompted"
        }
        
        
    }
    func randomNumber(count: Int) -> Int {
        return Int.random(in: 0..<count)
    }
    
    @IBAction func promptButttonPressed(_ sender: UIButton) {
        print("promptButtonPressed")
        promptLabel.text = prompts.promptArray[randomNumber(count: prompts.promptArray.count)]
        promptButton.isHidden = true
        
    }
    
    func contentTextView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                
                contentTextView.resignFirstResponder()
                return false
            }
            return true
        }
 
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUserInterface()
        post.timePosted = Date()
        post.numberOfLikes = 0
        post.numberOfComments = 0
        post.postingUserID = ""
       
        
        post.saveData { success in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.oneButtonAlert(title: "Save Failed", message: "For some reason Data would not save to the Cloud")
            }
        }
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

}
