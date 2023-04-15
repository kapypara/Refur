//
//  HomeCollectionViewCell.swift
//  Refur
//
//  Created by ghufran almoamen  on 09/04/2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    
    func setupCell(image: UIImage){
        cellImageView.image = image
    }
    

    func setupCell(uuid: String) {
        
        Database.Storage.loadImage(view: cellImageView, uuid: uuid)
    }
    
    func setupCell(post: Post) {
        Database.Storage.loadImage(view: cellImageView, uuid: post.images[0])
    }
}
