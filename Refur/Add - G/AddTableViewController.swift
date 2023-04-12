//
//  AddTableViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 01/04/2023.
//

import UIKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemImage: UIImage = UIImage(systemName: "photo.fill.on.rectangle.fill")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(indexPath)
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemHeadCell", for: indexPath) as! ItemHeadCell
            
            cell.setupCell(image: itemImage)
            
            return cell
            
        default:
            break
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        return cell
    }
    
    
    
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

