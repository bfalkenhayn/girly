//
//  OnboardingViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/11/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
  
    var horoscopeUser: HoroscopeUser!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if horoscopeUser.signNumber >= 0 && nameField.text != nil {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
      
    }
    
    @IBAction func signSelected(_ sender: UIButton) {
        horoscopeUser.signNumber = sender.tag
        if horoscopeUser.signNumber >= 0 && nameField.text != nil {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
      
    }
    
    @IBAction func nameFieldChanged(_ sender: UITextField) {
        horoscopeUser.name = nameField.text!
        if horoscopeUser.signNumber >= 0 && nameField.text != nil {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
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
