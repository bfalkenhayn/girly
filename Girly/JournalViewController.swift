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

var prompts = Prompts()


var dictionary = ["String": "" ]
var promptDicitonary = ["String": ""]



//var dictionary = ["date" : "text field"]

class JournalViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var promptButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    var dateIndex = 0
    var calendar = Calendar(identifier: .gregorian)
    var content = ""
    var prompt = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        textView.delegate = self
        textView.becomeFirstResponder()
        loadData {
            self.updateUserInterface()
            
        }
        loadPromptData {
            self.updateUserInterface()
            
        }
        
        
        saveData()
        savePromptData()
        updateUserInterface()
       
    }
    

    
    
    @IBAction func dateChangeButton(_ sender: UIButton) {
        dictionary[dateLabel.text!] = textView.text
        promptDicitonary[dateLabel.text!] = promptLabel.text
        dateIndex += sender.tag
        updateUserInterface()
        saveData()
        savePromptData()
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                saveData()
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    
    func updateFromUserInterface() {
        content = textView.text ?? ""
        prompt = promptLabel.text ?? ""
    }
    
    func updateUserInterface() {
        
        var date = calendar.date(byAdding: .day, value: dateIndex, to: Date())
        dateLabel.text = dateFormatter.string(from: date!)
        promptLabel.text = promptDicitonary[dateLabel.text!]
        textView.text = dictionary[dateLabel.text!]
       
        if dateLabel.text == "\(dateFormatter.string(from: Date()))" {
            textView.isEditable = true
            shareButton.isHidden = false
            promptButton.alpha = 1

        } else if dateLabel.text != "\(dateFormatter.string(from: Date()))"  {
            textView.isEditable = false
            shareButton.isHidden = true
            promptButton.alpha = 0

        }
       
       
    }
    
    func randomNumber(count: Int) -> Int {
        return Int.random(in: 0..<count)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SharePost" {

            updateFromUserInterface()

            print("content is \(content)")
            print("prompt is \(prompt)")
            let destination = segue.destination as! NewPostViewController
            destination.cancelButton.customView?.alpha = 0

            destination.contentFromJournal = content
            destination.promptFromJournal = prompt
           
        }
    }
    
   

    @IBAction func todayButtonPressed(_ sender: UIButton) {
        dateIndex = 0
        updateUserInterface()
    }
    
    @IBAction func promptButtonPressed(_ sender: Any) {
        
        print("prompt Label Pressed")
        promptButton.isHidden = true
        
        promptLabel.text = prompts.promptArray[randomNumber(count: prompts.promptArray.count)]
        promptDicitonary[dateLabel.text!] = promptLabel.text
       savePromptData()
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
          dictionary = try jsonDecoder.decode([String: String].self, from: data)
            
           }
        catch {print("error in loading data")
    }
        print("load data")
        completed()
        
        
}
    
    
    func savePromptData() {
        print("save data functions")
      let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let documentURL = directoryURL.appendingPathComponent("prompt").appendingPathExtension("json")
      let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(promptDicitonary)
      do {
          try data?.write(to: documentURL, options: .noFileProtection)
         
      } catch {print("error: could not save data")}

  }
    
    func loadPromptData(completed: @escaping () -> ()) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("prompt").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
          promptDicitonary = try jsonDecoder.decode([String: String].self, from: data)
            
           }
        catch {print("error in loading data")
    }
        print("load data")
        completed()
        
        
}
}
