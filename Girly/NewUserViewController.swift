//
//  NewUserViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/25/22.
//

import UIKit

class NewUserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var astrologyInfo: [AstrologyInfo] = []
    
    var signs = ["aries" , "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces"]
    var dates = ["March 21 - April 19", "April 20 - May 20", "May 21 - June 21", "June 22 - July 22", "July 23 - August 22", "August 23- September 22", "September 23 - October 23", "October 23 - November 21", "November 22 - December 21", "December 22 - January 19", "January 20 - February 18", "February 19 - March 20"]
    
    var horoscopeUser: HoroscopeUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.isUserInteractionEnabled = true
        self.tableView.allowsSelection = true
       
        
        // Do any additional setup after loading the view.
    }
    
    func selectingPath() {
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        signLabel.text = signs[selectedIndexPath.row]
        horoscopeUser.starSign = signs[selectedIndexPath.row]
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        horoscopeUser = HoroscopeUser(starSign: signLabel.text!, name: nameTextField.text!)
      
    }
    @IBAction func returnPressed(sender: UITextField) {
        resignFirstResponder()
        
        self.view.endEditing(true)
    }
   
    
    @IBAction func nameFieldChanged(_ sender: UITextField) {
        horoscopeUser.name = nameTextField.text!

        
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

extension NewUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewUserTableViewCell
        
        cell.signDatesLabel.text = dates[indexPath.row]
        cell.signLabel.text = signs[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(signs[indexPath.row])")
       return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signs.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow

        let currentCell = tableView.cellForRow(at: indexPath!) as! NewUserTableViewCell
        signLabel.text = signs[indexPath!.row]
        horoscopeUser.starSign = currentCell.signLabel.text!
        

        }
}
