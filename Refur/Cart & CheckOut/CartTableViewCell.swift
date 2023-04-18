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
            Cart.cart[cartItemIndex].selection = itemSelected
        }
    }
    

    @IBAction func checkmarkBtnTapped(_ sender: UIButton) {
        itemSelected.toggle()
    }
    
    
    func setupCell(cartItemIndex: Int) {
        
        guard cartItemIndex < Cart.cart.count else { return }
        
        
        self.cartItemIndex = cartItemIndex
        
        let cartItem = Cart.cart[cartItemIndex]
        itemSelected = cartItem.selection
        
        if let image = cartItem.item.images.first {
            Database.Storage.loadImage(view: itemImage, uuid: image)
        }
        
        itemName.text = cartItem.item.item.description
        price.text = "BD\(cartItem.item.item.price)"
        
        
        Database.Users.getUser(user: cartItem.item.userUuid) { loadedProfile in
            
            guard let username = loadedProfile?.name else { return }
            
            self.username.text = username
        }
    }

}
