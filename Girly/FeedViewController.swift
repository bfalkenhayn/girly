//
//  FeedViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/13/22.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    var posts: Posts!
    var post: Post!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        posts.loadData {
            self.sortBasedOnSegmentPressed()
            self.tableView.reloadData()
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = Posts()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func sortBasedOnSegmentPressed(){
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            posts.postArray.sort(by: {$0.numberOfLikes > $1.numberOfLikes})
           
        case 1:
            posts.postArray.sort(by: {$0.timePosted > $1.timePosted})
        default:
            0
        }
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPost" {
            let destination = segue.destination as! PostDetailViewController
             let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.post = posts.postArray[selectedIndexPath.row]
        }
    }
    
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
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

extension FeedViewController: UITableViewDelegate, UITableViewDataSource, FeedTableViewCellDelegate {
    func likePress(sender: FeedTableViewCell) {
        if let selectedIndexPath = tableView.indexPath(for: sender) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: selectedIndexPath) as! FeedTableViewCell
            cell.cellLiked = !cell.cellLiked
            
            if cell.cellLiked == true {
                posts.postArray[selectedIndexPath.row].numberOfLikes += 1
            } else {
                posts.postArray[selectedIndexPath.row].numberOfLikes += 1
            }
//
        
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            posts.postArray[selectedIndexPath.row].saveData(completion: { [self] success in
                if success {
                    print("number of likes is \(self.posts.postArray[selectedIndexPath.row].numberOfLikes)")
                }
            })
            
            
        }
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
       
        cell.post = posts.postArray[indexPath.row]
//        if cell.likeButton.isSelected {
//            posts.postArray[indexPath.row].numberOfLikes += 1}
        cell.likeButton.isSelected = cell.cellLiked
        cell.delegate = self
               cell.layer.masksToBounds = true
               cell.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
