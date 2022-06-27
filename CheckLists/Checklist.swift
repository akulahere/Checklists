//
//  Checklist.swift
//  CheckLists
//
//  Created by Dmytro Akulinin on 27.06.2022.
//

import UIKit

class Checklist: NSObject, Codable {
  var name = ""
  var items = [ChecklistItem]()
  init(name: String) {
    self.name = name
    super.init()
  }
}
