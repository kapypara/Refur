//
//  ClothingCategoryCollectionViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 03/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class ClothingCategoryCollectionViewController: UICollectionViewController {
 
   var arrayClothes: [clothingItems] = [
    
    
    clothingItems(clothingLabel: "@sThrifts", uuid: "clothes1.jpeg"),
    clothingItems(clothingLabel: "@Kapy", uuid: "clothes2.webp"),
    clothingItems(clothingLabel: "@thriftG", uuid: "clothes3.avif"),
    clothingItems(clothingLabel: "@yhs", uuid: "clothes4.jpeg"),
    clothingItems(clothingLabel: "@Gigi", uuid: "clothes5.jpeg"),
    clothingItems(clothingLabel: "@Ahmed", uuid: "clothes6.jpeg")
    
   ]
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayClothes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClothesCell", for: indexPath) as! CategoriesCollectionViewCell
    
        // Configure the cell
        let clothes = arrayClothes[indexPath.row]
        
        
        
        //let image = Database.Storage.loadImage(view: <#T##UIImageView#>, uuid: <#T##String#>)
        
        //cell.setupCell(image: clothes.clothingImage.image!, label: clothes.clothingLabel)
        cell.setupCell(uuid: clothes.uuid, label: clothes.clothingLabel)
        
        return cell
    }

    struct clothingItems {
        //let clothingImage : UIImageView
        
        let clothingLabel : String
        
        // debug
        let uuid: String
    }

}
