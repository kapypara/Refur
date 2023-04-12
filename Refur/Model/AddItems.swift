//
//  addItems.swift
//  Refur
//
//  Created by iOSdev on 12/04/2023.
//

import UIKit

class AddItems {
    
    var name: String? = nil
    var description: String? = nil
    
    var price: Double? = nil
    var condition: ItemCondition? = nil
    
    var category: ItemCategory? = nil

    var type: Any? = nil
    var size: Any? = nil
    var brand: String? = nil
    
    var typeMenuOpen = false
    var conditionMenuOpen = false
    var categoryMenuOpen = false
    
    var controller: UITableViewController!
}
