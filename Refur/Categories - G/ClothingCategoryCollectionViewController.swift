//
//  ClothingCategoryCollectionViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 03/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class ClothingCategoryCollectionViewController: UICollectionViewController {
    
    var arrayClothes = [clothingItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
     //   var image1: UIImage = Database.Storage.loadImage(view: image, uuid: "jon")
      //  arrayClothes.append(clothingItems(clothingImage: image1, clothingLabel: "hi"))
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    struct clothingItems {
        let clothingImage : UIImage
        let clothingLabel : String
    }

}
