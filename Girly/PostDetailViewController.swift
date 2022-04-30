//
//  PostDetailViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/25/22.
//

import UIKit

class PostDetailViewController: UIViewController {
    @IBOutlet weak var commentTableView: UITableView!
    var comments: Comments!
    var comment:Comment!
    var post:Post!
    @IBOutlet weak var postTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        comments = Comments()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        postTextView.text = post.content
        // Do any additional setup after loading the view.
        comments.loadData(post: post) {
            self.commentTableView.reloadData()
            
        }
        postTextView.layer.cornerRadius = 8
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewComment" {
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.viewControllers.first as! NewCommentViewController
            destination.post = post
            destination.comment = comment
            
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

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8
        cell.comment = comments.commentsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
