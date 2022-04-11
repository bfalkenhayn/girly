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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        horoscopeDetail = HoroscopeDetail(starSign: "aries", name: "", signNumber: 0)
      
        horoscopeDetail.getData {
            DispatchQueue.main.async {
                self.horoscopeLabel.text = self.horoscopeDetail.horoscope
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
