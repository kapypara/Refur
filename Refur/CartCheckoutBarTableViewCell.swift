//
//  CartCheckoutBarTableViewCell.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

class CartCheckoutBarTableViewCell: UITableViewCell {
    
    var selectAll = false
    @IBOutlet var totalLbl: UILabel!
    @IBOutlet var checkoutQuantity: UILabel!
    
    
    @IBOutlet var allChosen: UIButton!
    
    
    
    @IBAction func allChosenBtnTapped(_ sender: Any) {
        selectAll = true
     
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
