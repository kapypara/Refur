//
//  Cart.swift
//  Refur
//
//  Created by iOSdev on 12/04/2023.
//

import Foundation

struct CartItem {
    
    let cartItem: Post
    var selected: Bool
    
    init(cartItem: Post, selected: Bool) {
        self.cartItem = cartItem
        self.selected = selected
    }
}

class Cart {
    
    static var cart: [CartItem] = []
    
    private init() { }
    
    static func addToCart(itemPost: Post) {
        
        cart.append(CartItem(cartItem: itemPost, selected: true))
    }
    
}
