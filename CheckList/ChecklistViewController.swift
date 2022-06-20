//
//  ViewController.swift
//  CheckList
//
//  Created by Dmitro Akulinin on 20.06.2022.
//

import UIKit

class ChecklistViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    let label = cell.viewWithTag(1000) as! UILabel
    if indexPath.row % 5 == 0 {
        label.text = "Walk the dog"
      } else if indexPath.row % 5 == 1 {
        label.text = "Brush my teeth"
      } else if indexPath.row % 5 == 2 {
        label.text = "Learn iOS development"
      } else if indexPath.row % 5 == 3 {
        label.text = "Soccer practice"
      } else if indexPath.row % 5 == 4 {
        label.text = "Eat ice cream"
      }
    
    return cell
  }
  
  // MARK: Table View Delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      if cell.accessoryType == .none {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  


}

