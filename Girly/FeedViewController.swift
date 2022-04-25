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
            posts.postArray.sort(by: {$0.numberOfLikes < $1.numberOfLikes})
           
        case 1:
           0
        default:
            0
        }
        tableView.reloadData()
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

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func likePress(sender: FeedTableViewCell) {
        if let selectedIndexPath = tableView.indexPath(for: sender){
            posts.postArray[selectedIndexPath.row].numberOfLikes += 1
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
       
        cell.post = posts.postArray[indexPath.row]
        
               cell.layer.masksToBounds = true
               cell.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
