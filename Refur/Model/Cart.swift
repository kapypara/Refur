//
//  Cart.swift
//  Refur
//
//  Created by iOSdev on 12/04/2023.
//

import Foundation

struct CartItem {
    
    let item: Post
    var selection: Bool
    
    init(item: Post, selection: Bool) {
        self.item = item
        self.selection = selection
    }
}

class Cart {
    
    static var cart: [CartItem] = []
    
    private init() { }
    
    static subscript (index: Int) -> CartItem {
        return Cart.cart[index]
    }
    
    static func addToCart(itemPost: Post) {
        
        cart.append(CartItem(item: itemPost, selection: true))
    }
    
    static func removeFromCart(itemIdex: Int) {
        if itemIdex < Cart.cart.count {
            Cart.cart.remove(at: itemIdex)
        }
    }
}
