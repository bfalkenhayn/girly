//
//  ToDoDetailTTableViewController.swift
//  ToDo List
//
//  Created by Bridget Falkenhayn on 2/18/22.
//

import UIKit
import UserNotifications

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
}()

class ToDoDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var reminderSwitch: UISwitch!
   
    
    
    
    var toDoItem: Agenda!
    
    func updateUserInterface() {
        nameField.text = toDoItem.activity
        datePicker.date = toDoItem.time
        noteView.text = toDoItem.notes
        reminderSwitch.isOn = toDoItem.reminderSet
        
        enableDisableSaveButton(text: nameField.text!)
        
    }
    
    func updateReminderSwitch() {
        LocalNotificationsManager.isAuthorized { authorized in
            DispatchQueue.main.async {

                if !authorized && self.reminderSwitch.isOn   {
                    self.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To receive alerts for reminders, open the Settings app, selected To Do List > Notifications > Allow Notifications")
                    self.reminderSwitch.isOn = false


                }
               
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                self.view.endEditing(true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        if toDoItem == nil {
            toDoItem = Agenda(time: Date(), activity: "", notes: "", reminderSet: false, notificationID: "", completed: false)
            nameField.becomeFirstResponder()
        }
        updateUserInterface()
        nameField.becomeFirstResponder()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appActiveNotification), name: UIApplication.didBecomeActiveNotification, object: nil )
    }
    
    @objc func appActiveNotification() {
        print("App just came to the forground")
        updateReminderSwitch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        toDoItem = Agenda(time: datePicker.date, activity: nameField.text!, notes: noteView.text, reminderSet: reminderSwitch.isOn, notificationID: "", completed: false)
        
      
    }
    
    func enableDisableSaveButton(text: String) {
        if text.count > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentinginAddMode = presentingViewController is UINavigationController
        if isPresentinginAddMode {
            dismiss(animated: true, completion: nil)
        }
        else {navigationController?.popViewController(animated: true)}
    }
    @IBAction func reminderSwitchChange(_ sender: UISwitch) {
        updateReminderSwitch()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        self.view.endEditing(true)
        
        }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        enableDisableSaveButton(text: sender.text!)
    }
    
}

extension ToDoDetailTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case IndexPath(row: 1, section: 1): return
            reminderSwitch.isOn ? datePicker.frame.height : 0
        case IndexPath(row: 0, section: 3):
            return 200
        default:
            return 44
            
            
        }
    }
}

extension ToDoDetailTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteView.becomeFirstResponder()
        return true
    }
}
