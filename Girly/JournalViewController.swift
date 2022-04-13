//
//  JournalViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/13/22.
//

import UIKit
private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
  
    return dateFormatter
}()

var dictionary = ["date" : "text field"]

class JournalViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var dateIndex = 0
    var calendar = Calendar(identifier: .gregorian)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
        dictionary[dateLabel.text!] = textView.text ?? ""
        saveData()
        
       
    }
    
    
    @IBAction func dateChangeButton(_ sender: UIButton) {
        dictionary[dateLabel.text!] = textView.text ?? ""
        dateIndex += sender.tag
        updateUserInterface()
        
    }
    
    func updateUserInterface() {
        var date = calendar.date(byAdding: .day, value: dateIndex, to: Date())
        dateLabel.text = dateFormatter.string(from: date!)
        textView.text = dictionary[dateLabel.text!]
        if dateLabel.text != "\(dateFormatter.string(from: Date()))" {
            textView.isEditable = false
        } else {
            textView.isEditable = true
        }
    }
    
   

    
    @IBAction func todayLabelPressed(_ sender: UITapGestureRecognizer) {
        dateIndex = 0
        updateUserInterface()
    }
    
    @IBAction func promptLabelPressed(_ sender: UITapGestureRecognizer) {
        print("prompt Label Pressed")
    }
    
    
    
    
    func saveData() {
        print("save data functions")
      let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let documentURL = directoryURL.appendingPathComponent("journal").appendingPathExtension("json")
      let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(dictionary)
      do {
          try data?.write(to: documentURL, options: .noFileProtection)
         
      } catch {print("error: could not save data")}

  }
    
    func loadData(completed: @escaping () -> ()) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("journal").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
//            dictionary = try jsonDecoder.decode(dictionary.self, from: data)
            
           }
        catch {print("error in loading data")
    }
        print("load data")
        completed()
        
        
}
    
    
    
}
