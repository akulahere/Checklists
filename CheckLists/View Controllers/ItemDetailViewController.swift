//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Dmytro Akulinin on 21.06.2022.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
  weak var delegate: AddItemViewControllerDelegate?
  var itemToEdit: ChecklistItem?


  @IBOutlet var textField: UITextField!
  
  @IBOutlet var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var shouldRemindSwitch: UISwitch!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      doneBarButton.isEnabled = true
      shouldRemindSwitch.isOn = item.shouldRemind
      datePicker.date = item.dueDate

    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  // MARK: - Actions

  @IBAction func cancel() {
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    if let item = itemToEdit {
      item.text = textField.text!
      
      item.shouldRemind = shouldRemindSwitch.isOn
      item.dueDate = datePicker.date
      item.scheduleNotification()
      delegate?.itemDetailViewController(
        self,
        didFinishEditing: item)
    } else {
      let item = ChecklistItem()
      item.text = textField.text!
      item.checked = false
      
      item.shouldRemind = shouldRemindSwitch.isOn
      item.dueDate = datePicker.date
      item.scheduleNotification()
      delegate?.itemDetailViewController(
        self,
        didFinishAdding: item)
    }
  }
  
  @IBAction func shouldRemindToggled(_ switchControl: UISwitch) {
    textField.resignFirstResponder()
    
    if switchControl.isOn {
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.alert, .sound]) {_, _ in
        // do nothing
      }
    }
  }
  
  
  // MARK: - Table View Delegates

  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
  // MARK: - Text Field Delegates

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    if newText.isEmpty {
      doneBarButton.isEnabled = false
    } else {
      doneBarButton.isEnabled = true
    }
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    doneBarButton.isEnabled = false
    return true
  }
}
