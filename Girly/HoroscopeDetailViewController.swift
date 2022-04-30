//
//  HoroscopeDetailViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/11/22.
//

import UIKit

class HoroscopeDetailViewController: UIViewController {
    @IBOutlet weak var horoscopeLabel: UILabel!
    var horoscopeDetail: HoroscopeDetail!
    var starSign = ""
    var horoscope = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horoscopeLabel.text = horoscope
    }
    
    func loadStarSign() {
        guard let starSignEncoded = UserDefaults.standard.value(forKey: "starSign") as? Data else {
            print("error: could not load from starSign, but this is fine if first time app is run")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
    
            return
        }
        let decoder = JSONDecoder()
        if let starSign = try? decoder.decode(String.self, from: starSignEncoded) as! String { self.starSign = starSign}
        else {
            print("error coudlnt decode data read from user defaults")
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
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
