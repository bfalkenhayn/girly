//
//  HomeViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/8/22.
//

import UIKit
import UserNotifications
import CoreLocation
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    
    return dateFormatter
}()
class HomeViewController: UIViewController, ListTableViewCellDelegate {
    
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var horoscopeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    
    
    
    var agendaItems: AgendaItems!

    var weatherDetail: WeatherDetail!
    var locationManager: CLLocationManager!
    var horoscopeDetail: HoroscopeDetail!
    var quoteAPICall: QuoteAPICall!
    var starSign = ""
    var horoscopeUser: HoroscopeUser!
    
    var users: Users!
    var user: User!
    var authUI: FUIAuth!
    var calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.agendaItems.agendaArray.count != 0 {
            self.addButton.isHidden = true
            self.addButton.isEnabled = false
        }
        getLocation()
        weatherDetail = WeatherDetail(name: "current locatiton", latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.latitude ?? 0.0)
        weatherLabel.text = ""
        
        
        weatherDetail.getData {
            DispatchQueue.main.async {
                print(self.weatherDetail.name)
                self.weatherLabel.text = "\(self.weatherDetail.summary) \(self.weatherDetail.dayIcon) \(self.weatherDetail.temperature)°"
                
            }
        }
        
    }
    
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        quoteLabel.text = ""
       
       
        quoteAPICall = QuoteAPICall()
        agendaItems = AgendaItems()
        users = Users()
        let currentUser = Auth.auth().currentUser
        
        
        loadStarSign()

        
        quoteAPICall.getData {
            DispatchQueue.main.async {
                self.quoteLabel.text = "\(self.quoteAPICall.content) -\(self.quoteAPICall.author)"
            }
            
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        dateLabel.text = dateFormatter.string(from: Date())
        LocalNotificationsManager.authorizeLocalNotifications(viewController: self)
        // Do any additional setup after loading the view.
        
        horoscopeDetail = HoroscopeDetail(starSign: starSign, name: "")
        
        horoscopeDetail.getData {
            DispatchQueue.main.async {
                self.horoscopeLabel.text = "\(self.horoscopeDetail.horoscope)"
            }
        }
        
        agendaItems.loadData {
            self.tableView.reloadData()
       
        }
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadStarSign()
        horoscopeDetail.getData {
            DispatchQueue.main.async {
                self.horoscopeLabel.text = "\(self.horoscopeDetail.horoscope)"
            }
        }
    }
    
    @IBAction func tapPressed(_ sender: UITapGestureRecognizer) {
        print("tap Gesture Pressed")
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier {
        case "FromCell":
            let destination = segue.destination as! ToDoDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.toDoItem = agendaItems.agendaArray[selectedIndexPath.row]
            
//        case "NewUser":
//            let destination = segue.destination as! OnboardingViewController
//            destination.horoscopeUser = HoroscopeDetail(starSign: "", name: "")
            
        case "HoroscopeDetail":
            let destination = segue.destination as! HoroscopeDetailViewController
            destination.horoscope = horoscopeLabel.text!
        default:
            if let selectedIndexPath = tableView.indexPathForSelectedRow { tableView.deselectRow(at: selectedIndexPath, animated: true)}
            
        }
        
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
    
        let source = segue.source as! ToDoDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow{ agendaItems.agendaArray[selectedIndexPath.row] = source.toDoItem
           
            agendaItems.saveData()
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        else {
            
        

            let newIndexPath = IndexPath(row: agendaItems.agendaArray.count, section: 0
            )
            agendaItems.saveData()
            agendaItems.agendaArray.append(source.toDoItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
            
            
        }
        agendaItems.saveData()
        print("AITEMS: \(agendaItems.agendaArray)")
        
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
        if let starSign = try? decoder.decode(String.self, from: starSignEncoded) as! String { self.starSign = starSign
            
        }
        else {
            print("error coudlnt decode data read from user defaults")
        }
       
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func checkBoxToggle(sender: ListTableViewCell) {
        if let selectedIndexPath = tableView.indexPath(for: sender){
            agendaItems.agendaArray[selectedIndexPath.row].completed = !agendaItems.agendaArray[selectedIndexPath.row].completed
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            agendaItems.saveData()        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        cell.delegate = self
        
        cell.toDoItem = agendaItems.agendaArray[indexPath.row]
//        cell.toDoItem = todayAgendaArray.agendaArray[indexPath.row]
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendaItems.agendaArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            agendaItems.agendaArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        if agendaItems.agendaArray.count != 0 {
            addButton.isHidden = true
            addButton.isEnabled = false
        } else {
            addButton.isHidden = false
            addButton.isEnabled = true
        }
    
        agendaItems.saveData()
    }
    
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func getLocation() {
        //        Check location authorization
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthenticalStatus(status: status)
    }
    
    func handleAuthenticalStatus(status: CLAuthorizationStatus){
        switch status {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            self.oneButtonAlert(title: "Location Services Denied", message: "It may be that parental controls are restricting location use in this app.")
        case .denied:
            showAlertToPrivacySettings(title: "User has not authorized location services", message: "Select 'Settings' below to open device settings and enable location")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            print("developer alert")
        }
    }
    
    func showAlertToPrivacySettings(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            print("error in URL settings string")
            return
        }
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //TODO: deal with change in location
        let currentLocation = locations.last ?? CLLocation()
        print("current location is \(currentLocation)")
        print("❤️\(CLLocation())")
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
            var locationName = ""
            if placemarks != nil {
                let placemark = placemarks?.last
                locationName = placemark?.name ?? "Place Unknown"
            } else {
                locationName = "Could not find Location"
            }
            
        }
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: Deal with error
    }
}
