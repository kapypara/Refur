//
//  OthersCategoryCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 03/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class OthersCategoryCollectionViewController: UICollectionViewController {

    var arrayOthers: [othersItems] = [
        othersItems(othersLabel: "@green", uuid: "others1.jpeg"),
        othersItems(othersLabel: "@red", uuid: "others2.png"),
        othersItems(othersLabel: "@blue", uuid: "others3.jpeg"),
        othersItems(othersLabel: "@white", uuid: "others4.jpeg"),
        othersItems(othersLabel: "@gold", uuid: "others5.jpeg"),
        othersItems(othersLabel: "@green", uuid: "others6.jpeg"),
        othersItems(othersLabel: "@red", uuid: "others7.jpeg"),
        othersItems(othersLabel: "@orange", uuid: "others8.jpeg"),
        othersItems(othersLabel: "@black", uuid: "others9.jpeg"),
        othersItems(othersLabel: "@beige", uuid: "others10.jpeg"),


        
    ]
   

     
     override func viewDidLoad() {
         super.viewDidLoad()
         collectionView.delegate = self
         collectionView.dataSource = self
     }



     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         // #warning Incomplete implementation, return the number of items
         return arrayOthers.count
     }

     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OthersCell", for: indexPath) as! CategoriesCollectionViewCell
     
         // Configure the cell
         let others = arrayOthers[indexPath.row]
         cell.setupCell(uuid: others.uuid, label: others.othersLabel  )
         return cell
     }

     struct othersItems {
         let othersLabel : String
         let uuid: String
     }



}
