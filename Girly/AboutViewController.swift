//
//  AboutViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/25/22.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users: Users!
    @IBOutlet weak var countLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    users = Users()
        users.loadData { [self] in
            self.countLabel.text = "Number of Users: \(self.users.userArray.count)"
        }
    
        
        // Do any additional setup after loading the view.
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

