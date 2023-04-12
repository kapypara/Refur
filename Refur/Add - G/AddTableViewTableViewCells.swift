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
    
    func setupCell(image: UIImage) {
        
        itemImage.image = image
    }
    

}

class PirceCell: UITableViewCell {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    
    @IBAction func priceChanged(_ sender: Any) {
        
        if priceTextField.text!.isEmpty {
            totalTextField.text = ""
            return
        }
        
        guard
            let priceText = priceTextField.text,
            let price = Double(priceText)
        else {
            return
            
        }
        
        totalTextField.text = "BD\(price)"
    }
}

class DropMenuCell: UITableViewCell {

    @IBOutlet weak var MenuName: UILabel!
    
    @IBOutlet weak var SelectionName: UIButton!
    
    @IBOutlet weak var selection1: UIButton!
    @IBOutlet weak var selection2: UIButton!
    @IBOutlet weak var selection3: UIButton!
    
    var menuButtons: [UIButton] = []
    
    func setupCell(name: String, selections: [String]) {
        
        menuButtons = [ selection1, selection2, selection3 ]
        
        MenuName.text = name
        
        SelectionName.setTitle("Item's " + name, for: .normal)
        
        if selections.count > 0 {
            selection1.setTitle(selections[0] + name, for: .normal)
            selection1.isHidden = false
        } else {
            selection1.isHidden = true
        }
        
        if selections.count > 1 {
            selection2.setTitle(selections[1] + name, for: .normal)
            selection2.isHidden = false
        } else {
            selection2.isHidden = true
        }
        
        if selections.count > 2 {
            selection3.setTitle(selections[2] + name, for: .normal)
            selection3.isHidden = false
        } else {
            selection3.isHidden = true
        }
    }
    
    
    func menuButtonsVisibility() {
        menuButtons.forEach { button in
            UIView.animate(withDuration: 0.20) {
                button.isHidden = !button.isHidden
                self.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func categoryButtonClicked(_ sender: Any) {
        menuButtonsVisibility()
        
    }
    
    @IBAction func categoriesButtonsClicked(_ sender: UIButton) {
        menuButtonsVisibility()
        SelectionName.setTitle(sender.currentTitle, for: .normal)
        
        //print(sender.titleLabel!.text!)
        /*
        switch sender.currentTitle {
        case "Clothes":
            seletedCatgegory = .Clothing
            selectCategoryButton.setTitle("Clothes", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
            
        case "Books":
            seletedCatgegory = .Book
            selectCategoryButton.setTitle("Books", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
            
        default: // selection3
            seletedCatgegory = .Other
            selectCategoryButton.setTitle("Others", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
        }
     */
    }
}

class FieldCell: UITableViewCell {

    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var FieldInput: UITextField!
    
}

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var DescriptionInput: UITextField!
    
}

class PostCell: UITableViewCell {


}

