//
//  AddItemViewController.swift
//  CheckList
//
//  Created by Dmytro Akulinin on 21.06.2022.
//

import UIKit

class AddItemViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
  }
  
  //MARK: - Actions
  @IBAction func cancel() {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func done() {
    navigationController?.popViewController(animated: true)
  }
}

