//
//  AddTableViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 01/04/2023.
//

import UIKit

class AddTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var selectCategoryButton: UIButton!
    @IBOutlet var categoriesButtons: [UIButton]!
    @IBOutlet weak var selectConditionButton: UIButton!
    @IBOutlet var conditionsButtons: [UIButton]!
    @IBOutlet weak var itemDetailsTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var selectSizeButton: UIButton!
    @IBOutlet var sizeButtons: [UIButton]!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    var seletedCatgegory: ItemCategory = .Clothing
    var selectedCondition: ItemCondition = .GoodCondition
    var selectedSize: ClothingSize = .Small
    
    @IBAction func newItem() {
        // TODO: add safety meausrs
        
        let price = Double(priceTextField.text!)!
        
        let item = Item.Clothing(name: itemDetailsTextField.text!,
                                 description: descriptionTextField.text!,
                                 condition: selectedCondition,
                                 price: price,
                                 type: .TShirt,
                                 size: selectedSize
        )
        print(item.name)
        
    }
    
    
// MARK: Image Picker Button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        present(viewController, animated: true)
    }
    
    // MARK: Quantity Stepper
    @IBAction func quantityStepper(_ sender: UIStepper) {
        stepperLabel.text = String(Int(sender.value))

    }
    
    // MARK: Category Selection
    // If category (books) button clicked
    
    
    func categoryButtonsVisibility() {
        categoriesButtons.forEach { button in
            UIView.animate(withDuration: 0.20) {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func categoryButtonClicked(_ sender: Any) {
        categoryButtonsVisibility()
        
    }
    
    @IBAction func categoriesButtonsClicked(_ sender: UIButton) {
        categoryButtonsVisibility()
        print(sender.titleLabel!.text!)
        switch sender.currentTitle {
        case "Clothes":
            seletedCatgegory = .Clothing
            selectCategoryButton.setTitle("Clothes", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
            
        case "Books":
            seletedCatgegory = .Book
            selectCategoryButton.setTitle("Books", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
            
        case "Others":
            seletedCatgegory = .Other
            selectCategoryButton.setTitle("Others", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
        default:
            return
        }
        
    }
    
    // MARK: Condition Selection
    
    func conditionsButtonsVisibility() {
        conditionsButtons.forEach { button in
            UIView.animate(withDuration: 0.2) {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func conditionButtonClicked(_ sender: UIButton) {
        conditionsButtonsVisibility()
    }
    
    
    @IBAction func conditionStateSelected(_ sender: UIButton){
        conditionsButtonsVisibility()
        print(sender.titleLabel!.text!)
        switch sender.currentTitle {
        case "Brand New":
            selectedCondition = .BrandNew
            selectConditionButton.setTitle("Brand New", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
            
        case "As Good As New":
            selectedCondition = .AsGoodAsNew
            selectConditionButton.setTitle("As Good As New", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
            
        case "Good Condition":
            selectedCondition = .GoodCondition
            selectConditionButton.setTitle("Good Condition", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
            
        case "Used":
            selectedCondition = .Used
            selectConditionButton.setTitle("Used", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
            
        default:
            return
        }
        
    }
    
    // MARK: Size Selection
    func sizeButtonsVisibility() {
        sizeButtons.forEach { button in
            UIView.animate(withDuration: 0.2) {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func sizeButtonClicked(_ sender: UIButton) {
        sizeButtonsVisibility()
    }
    
    
    @IBAction func sizeStateSelected(_ sender: UIButton){
        sizeButtonsVisibility()
        print(sender.titleLabel!.text!)
        switch sender.currentTitle {
        case "Small":
            selectedSize = .Small
            selectSizeButton.setTitle("Small", for: .normal)
            selectSizeButton.setImage(nil, for: .normal)
            
        case "Medium":
            selectedSize = .Medium
            selectSizeButton.setTitle("Medium", for: .normal)
            selectSizeButton.setImage(nil, for: .normal)
            
        case "Large":
            selectedSize = .Large
            selectSizeButton.setTitle("Large", for: .normal)
            selectSizeButton.setImage(nil, for: .normal)
        default:
            return
        }
        
    }
    
}


// MARK: Image Picker delegate and functionality
extension AddTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
