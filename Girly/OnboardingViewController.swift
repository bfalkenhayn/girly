//
//  OnboardingViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/11/22.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
   
  
    @IBOutlet var signButtons: [UIButton]!
    
    @IBOutlet weak var signLabel: UILabel!
   
    var starSign = ""
  
   
    override func viewDidLoad() {
        super.viewDidLoad()

        if starSign == "" {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
    }
    
    
    @IBAction func buttonTest(_ sender: Any) {
        print("button was pressed")
    }
    
    
    
    func saveStarSign() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(starSign){
            UserDefaults.standard.set(encoded, forKey: "starSign")
        }
        else {
            print("Saving encoded didn't work")
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
       
        saveStarSign()
    }
    @IBAction func signSelected(_ sender: UIButton) {
        var signNumber = sender.tag
        print("sign selected")
        
        
        switch signNumber {
        case 0:
          starSign = "aries"
        case 1:
           starSign = "taurus"
        case 2:
            starSign = "gemini"
        case 3:
           starSign = "cancer"
        case 4:
            starSign = "leo"
        case 5:
            starSign = "virgo"
        case 6:
           starSign = "libra"
        case 7:
          starSign = "scorpio"
        case 8:
          starSign = "sagitarius"
        case 9:
           starSign = "capricorn"
        case 10:
           starSign = "aquarius"
        case 11:
            starSign = "pisces"
        default:
           starSign = "aries"
            
        }
        
            signLabel.text = "Select Your Sign: \(starSign)"
        saveStarSign()
        if starSign == ""  {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
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
