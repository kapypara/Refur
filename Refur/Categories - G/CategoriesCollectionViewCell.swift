//
//  ClothesCategoryCollectionViewCell.swift
//  Refur
//
//  Created by ghufran almoamen  on 03/04/2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var clothingAddButton: UIButton!
    
    func setupCell(image: UIImage, label: String){
        cellImageView.image = image
        cellLabel.text = label
    }
    

    func setupCell(uuid: String, label: String) {
        
        Database.Storage.loadImage(view: cellImageView, uuid: uuid)
        cellLabel.text = label
    }
    
    
}
