//
//  NewCommentViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/25/22.
//

import UIKit

class NewCommentViewController: UIViewController {

    var comment:Comment!

    var post:Post!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        comment = Comment()
        
        // Do any additional setup after loading the view.
    }
    
    
    func updateFromInterface(){
        textView.text = comment.content
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        post.numberOfComments += 1
        comment.content = textView.text!
        comment.saveData(post: post) { [self] (sucess) in
            if sucess {
                comment.content = self.textView.text!
                print("INSIDE SAVE BUTTON: \(comment.content)")
                post.saveData { sucess in
                    if sucess {
                        self.comment.content = self.textView.text!
                        self.post.numberOfComments += 1
                    } else {
                        print("error in saving post data")
                    }
                }
               
                
                self.leaveViewController()
            } else {
                print("Error cannot unwind segue because of review saving error")
            }
        }
    }
    
    func leaveViewController(){
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
