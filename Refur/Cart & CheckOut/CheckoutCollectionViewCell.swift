//
//  CheckoutCollectionViewCell.swift
//  Refur
//
//  Created by iOSdev on 16/04/2023.
//

import UIKit

class CheckoutCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImage: UIImageView!
    
    func setupCell(post : Post) {
        Database.Storage.loadImage(view: itemImage, uuid: post.images[0])
    }
}
