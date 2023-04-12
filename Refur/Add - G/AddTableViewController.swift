//
//  AddTableViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 01/04/2023.
//

import UIKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemImage: UIImage = UIImage(systemName: "photo.fill.on.rectangle.fill")!
    
    var fields: AddItems = AddItems()
    
    var extraCells: Int {
        fields.category == ItemCategory.Clothing ? 0 : 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fields.controller = self
        
        //tableView.usesAutomaticRowHeights = true
    }
    
    @IBAction func newItem() {
        // TODO: add safety meausrs
        
        /*
        //let price = Double(priceTextField.text!)!
        
        let item = Item.Clothing(name: itemDetailsTextField.text!,
                                 description: descriptionTextField.text!,
                                 condition: selectedCondition,
                                 price: price,
                                 type: .TShirt,
                                 brnad: "ADD ME BUG",
                                 size: selectedSize
        )
        print(item.name)
        */
    }
    
    
    // MARK: tableView function
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 - extraCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath)
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemHeadCell", for: indexPath) as! ItemHeadCell
            
            cell.setupCell(fields, image: itemImage)
            
            return cell
            
        case 1:
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PirceCell", for: indexPath) as! PirceCell
            
            cell.setupCell(fields)
            
            return cell
            
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropMenuCell", for: indexPath) as! DropMenuCell
            
            cell.setupCell(fields, type: .Category, selections: [ ItemCategory.Clothing.rawValue, ItemCategory.Book.rawValue, ItemCategory.Other.rawValue ])
            
            return cell
            
        default:
            break
        }
        
        
        let indexOffset = indexPath.row + extraCells
        
        switch indexOffset {
        case 3: // brand
            let cell = tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath) as! FieldCell
            
            cell.setupCell(fields)
            
            return cell
            
        case 4: // condition
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropMenuCell", for: indexPath) as! DropMenuCell
            
            cell.setupCell(fields, type: .Condition, selections: [ ItemCondition.BrandNew.rawValue, ItemCondition.AsGoodAsNew.rawValue, ItemCondition.Used.rawValue ])
            
            return cell
            
        case 5: //Description
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            cell.setupCell(fields)
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            return cell
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
        case 2:
            
            guard
                let cell = tableView.cellForRow(at: indexPath) as? DropMenuCell,
                cell.selection1.isHidden
            else {
                return UITableView.automaticDimension
                
            }
            
            print(cell)
            return 90
            
        default:
            return UITableView.automaticDimension
        }
    }
    */
    
    // MARK: Image Picker Button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        present(viewController, animated: true)
    }

    // MARK: Image Picker delegate and functionality
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            itemImage = image
            tableView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

