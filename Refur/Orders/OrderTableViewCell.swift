//
//  OrderTableViewCell.swift
//  Refur
//
//  Created by iOSdev on 04/04/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet var orderNumber: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var handleLabel: UIView!
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var numberOfItems: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
