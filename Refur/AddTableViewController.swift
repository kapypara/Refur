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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func categoryButtonsVisibility() {
        categoriesButtons.forEach { button in
            UIView.animate(withDuration: 0.3) {
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
            selectCategoryButton.setTitle("Clothes", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
        case "Books":
            selectCategoryButton.setTitle("Books", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
        case "Others":
            selectCategoryButton.setTitle("Others", for: .normal)
            selectCategoryButton.setImage(nil, for: .normal)
        default:
            return
        }
        
    }
    
    // MARK: Condition Selection
    
    func conditionsButtonsVisibility() {
        conditionsButtons.forEach { button in
            UIView.animate(withDuration: 0.3) {
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
            selectConditionButton.setTitle("Brand New", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
        case "Very Good":
            selectConditionButton.setTitle("Very Good", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
        case "Fair":
            selectConditionButton.setTitle("Fair", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
        case "Used":
            selectConditionButton.setTitle("Used", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
        case "Poor":
            selectConditionButton.setTitle("Poor", for: .normal)
            selectConditionButton.setImage(nil, for: .normal)
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
