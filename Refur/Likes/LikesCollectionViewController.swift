//
//  LikesCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class LikesCollectionViewController: UICollectionViewController {

    let arrayLikes: [Post] = [
        Post(item: Item.Clothing(name: "Hello", description: "des", condition: .Used, price: 33.3, type: .TShirt, brnad: "Hee", size: .Medium), images: ["clothes1.jpeg"])
    ]
   

     
     override func viewDidLoad() {
         super.viewDidLoad()
         collectionView.delegate = self
         collectionView.dataSource = self
     }



     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         // #warning Incomplete implementation, return the number of items
         return arrayLikes.count
     }

     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikesCell", for: indexPath) as! CategoriesCollectionViewCell
     
         // Configure the cell
         let likes = arrayLikes[indexPath.row]
         
         cell.setupCall(post: likes)
         return cell
     }

    /*
     struct booksItems {
         let booksLabel : String
         
         // debug
         let uuid: String
     }
*/




}
