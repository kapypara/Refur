//
//  AddTableViewTableViewCells.swift
//  Refur
//
//  Created by iOSdev on 12/04/2023.
//

import UIKit

class ItemHeadCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UITextField!
    
    var ref: AddItems!
    
    func setupCell(_ ref: AddItems, image: UIImage) {
        
        itemImage.image = image
        
        self.ref = ref

        if let name = ref.name {
            itemName.text = name
        }
        
        updateCell()
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        updateCell()
    }
    
    func updateCell() {
        if !itemName.text!.isEmpty {
            ref.name = itemName.text!
        }
    }
}

class PirceCell: UITableViewCell {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    
    var ref: AddItems!
    
    @IBAction func priceChanged(_ sender: Any) {
        updateCell()
    }
    
    func setupCell(_ ref: AddItems) {
        self.ref = ref

        if let price = ref.price {
            priceTextField.text = String(price)
        }
        
        totalTextField.isUserInteractionEnabled = false
        
        updateCell()
    }
    
    func updateCell() {
        
        guard
            let price = Double(priceTextField.text!)
        else {
            totalTextField.text = ""
            return
        }
        
        ref.price = price
        totalTextField.text = String(format: "BD%.3f", price * 0.1)
    }
}

enum DropMenuType: String {
    case Condition, Category
}

class DropMenuCell: UITableViewCell {

    @IBOutlet weak var MenuName: UILabel!
    
    @IBOutlet weak var SelectionName: UIButton!
    
    @IBOutlet weak var selection1: UIButton!
    @IBOutlet weak var selection2: UIButton!
    @IBOutlet weak var selection3: UIButton!
    
    var menuButtons: [UIButton] = []
    var ref: AddItems!
    var type: DropMenuType!
    
    func setupCell(_ ref: AddItems, type: DropMenuType, selections: [String]) {
        
        self.type = type
        self.ref = ref
        
        menuButtons = [ selection1, selection2, selection3 ]
        MenuName.text = type.rawValue
        
        
        switch type {
        case .Category:
            if let name = ref.category?.rawValue {
                SelectionName.setTitle(name, for: .normal)
            } else {
                SelectionName.setTitle("Item's " + type.rawValue, for: .normal)
            }
            
        case .Condition:
            if let name = ref.condition?.rawValue {
                SelectionName.setTitle(name, for: .normal)
            } else {
                SelectionName.setTitle("Item's " + type.rawValue, for: .normal)
            }
        }
        
        
        if selections.count > 0 {
            selection1.setTitle(selections[0], for: .normal)
            selection1.isHidden = false
        } else {
            selection1.isHidden = true
        }
        
        if selections.count > 1 {
            selection2.setTitle(selections[1], for: .normal)
            selection2.isHidden = false
        } else {
            selection2.isHidden = true
        }
        
        if selections.count > 2 {
            selection3.setTitle(selections[2], for: .normal)
            selection3.isHidden = false
        } else {
            selection3.isHidden = true
        }
        
        menuButtonsVisibility()
    }
    
    
    func menuButtonsVisibility() {
        let menu: Bool
        
        switch type {
        case .Category:
            menu = ref.categoryMenuOpen
            
        default: // .Condition:
            menu = ref.conditionMenuOpen
        }
        
        
        menuButtons.forEach { button in
            UIView.animate(withDuration: 0.20) {
                button.isHidden = !menu
                self.layoutIfNeeded()
            }
        }
    }
    
    func toggleMenu() {
        switch type {
        case .Category:
            ref.categoryMenuOpen.toggle()
            
        default: //.Condition:
            ref.conditionMenuOpen.toggle()
        }
    }
    
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        toggleMenu()
        menuButtonsVisibility()
        
        ref.controller.tableView.reloadData()
    }
    
    @IBAction func menuButtonsClicked(_ sender: UIButton) {
        toggleMenu()
        
        switch type {
        case .Category:
            ref.category = ItemCategory(rawValue: sender.currentTitle!)
            
        default: //.Condition:
            ref.condition = ItemCondition(rawValue: sender.currentTitle!)
        }
        
        menuButtonsVisibility()
    
        ref.controller.tableView.reloadData()
    }
}

class FieldCell: UITableViewCell {

    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var FieldInput: UITextField!
    
    var ref: AddItems!
    
    func setupCell(_ ref: AddItems) {
        self.ref = ref
        
        if let brand = ref.brand {
            FieldInput.text = brand
        }
        
        fieldName.text = "Brand"
        FieldInput.placeholder = "Brand name..."
    }
    
    @IBAction func fieldChanged(_ sender: Any) {
        ref.brand = FieldInput.text
    }
    
}

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var DescriptionInput: UITextField!
    
    var ref: AddItems!
    
    func setupCell(_ ref: AddItems) {
        self.ref = ref
        
        if let brand = ref.description {
            DescriptionInput.text = brand
        }
    }
    
    @IBAction func fieldChanged(_ sender: Any) {
        ref.description = DescriptionInput.text
    }
}

class PostCell: UITableViewCell {

    @IBOutlet weak var postButton: UIButton!
    
    func setupCell(_ enabled: Bool) {
        postButton.isEnabled = enabled
    }
}

