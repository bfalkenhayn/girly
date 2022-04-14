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
        
//        
//        if horoscopeUser.signNumber! >= 0 && nameField.text != nil {
//            doneButton.isEnabled = true
//        } else {
//            doneButton.isEnabled = false
//        }
      
    }
    
    @IBAction func signSelected(_ sender: UIButton) {
        horoscopeUser.signNumber = sender.tag
//        if horoscopeUser.signNumber! >= 0 && nameField.text != nil {
//            doneButton.isEnabled = true
//        } else {
//            doneButton.isEnabled = false
//        }
        
        switch horoscopeUser.signNumber {
        case 0:
            horoscopeUser.starSign = "aries"
        case 1:
            horoscopeUser.starSign = "taurus"
        case 2:
            horoscopeUser.starSign = "gemini"
        case 3:
            horoscopeUser.starSign = "cancer"
        case 4:
            horoscopeUser.starSign = "leo"
        case 5:
            horoscopeUser.starSign = "virgo"
        case 6:
            horoscopeUser.starSign = "libra"
        case 7:
            horoscopeUser.starSign = "scorpio"
        case 8:
            horoscopeUser.starSign = "sagitarius"
        case 9:
            horoscopeUser.starSign = "capricorn"
        case 10:
            horoscopeUser.starSign = "aquarius"
        case 11:
            horoscopeUser.starSign = "pisces"
        default:
            horoscopeUser.starSign = "aries"
            
        }
      
    }
    
    @IBAction func nameFieldChanged(_ sender: UITextField) {
        horoscopeUser.name = nameField.text!
        if horoscopeUser.signNumber ?? -1 >= 0 && nameField.text != nil {
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
