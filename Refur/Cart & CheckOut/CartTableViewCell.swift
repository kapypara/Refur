//
//  CartTableViewCell.swift
//  Refur
//
//  Created by iOSdev on 05/04/2023.
//

import UIKit


class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet var isChosen: UIButton!
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var itemName: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var price: UILabel!
    
    var cartItemIndex: Int = 0
    var itemSelected: Bool = true {
        didSet {
            isChosen.isSelected = itemSelected
            Cart.cart[cartItemIndex].selected = itemSelected
        }
    }
    
    @IBAction func checkmarkBtnTapped(_ sender: UIButton) {
        itemSelected.toggle()
    }
    
    
    func setupCell(post: Post, selection: Bool) {
        
        itemSelected = selection
        
        if let image = post.images.first {
            Database.Storage.loadImage(view: itemImage, uuid: image)
        }
        
        itemName.text = post.item.description
        
        price.text = "BD\(post.item.price)"
        
        Database.Users.getUser(user: post.userUuid) { loadedProfile in
            
            guard let username = loadedProfile?.name else { return }
            
            self.username.text = username
        }
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
