//
//  CartTableViewCell.swift
//  Refur
//
//  Created by iOSdev on 05/04/2023.
//

import UIKit


protocol ToDoCellDelegate: AnyObject  {
    func checkmarkTapped(sender: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet var isChosen: UIButton!
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var itemNameLbl: UILabel!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var priceLabel: UILabel!

    @IBOutlet var quantityLbl: UILabel!
    @IBOutlet var quantityStepper: UIStepper!
    
    func updateQuantity()  {
        quantityLbl.text = "\(Int(quantityStepper.value))"
    }
    
    
    @IBAction func checkmarkBtnTapped(_ sender: UIButton) {
        
        isChosen.isSelected.toggle()
    }
    

    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateQuantity()
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
