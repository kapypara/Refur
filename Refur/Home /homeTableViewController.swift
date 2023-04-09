//
//  homeTableViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 09/04/2023.
//

import UIKit

class homeTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
// MARK: Home Collection View
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var picked4uCollectionView: UICollectionView!
    
    
    var categoriesArray: [categoriesItems] = [
      categoriesItems(uuid: "others1.jpeg"),
      categoriesItems(uuid: "books1.jpeg"),
      categoriesItems(uuid: "others3.jpeg"),
      categoriesItems(uuid: "clothes1.jpeg"),
      categoriesItems(uuid: "others5.jpeg"),
      categoriesItems(uuid: "clothes4.jpeg"),
      categoriesItems(uuid: "books7.jpeg"),
      categoriesItems(uuid: "clothes6.jpeg"),
      categoriesItems(uuid: "others9.jpeg"),
      categoriesItems(uuid: "others10.jpeg"),
    ]
    
    var featuredArray: [featuredItems] = [
      featuredItems(uuid: "clothes6.jpeg"),
      featuredItems(uuid: "others8.jpeg"),
      featuredItems(uuid: "others2.png"),
      featuredItems(uuid: "books7.jpeg"),
      featuredItems(uuid: "clothes4.jpeg"),
    ]
    
    var pickedArray: [pickedItems] = [
      pickedItems(uuid: "books1.jpeg"),
      pickedItems(uuid: "books5.jpeg"),
      pickedItems(uuid: "books3.jpeg"),
      pickedItems(uuid: "books8.jpeg"),
      pickedItems(uuid: "books10.jpeg"),
      pickedItems(uuid: "book2.jpeg"),
      pickedItems(uuid: "books4.jpeg"),
      pickedItems(uuid: "books7.jpeg"),
      pickedItems(uuid: "books9.jpeg")
    ]
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if (collectionView == categoriesCollectionView){
             return categoriesArray.count
         } else if (collectionView == featuredCollectionView) {
             return featuredArray.count
         }
         return pickedArray.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if (collectionView == categoriesCollectionView) {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! HomeCollectionViewCell
             let categorieslet = categoriesArray[indexPath.row]
             cell.setupCell(uuid: categorieslet.uuid)
             return cell
         }
         else if (collectionView == featuredCollectionView ){
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! HomeCollectionViewCell
             let featured = featuredArray[indexPath.row]
             cell.setupCell(uuid: featured.uuid)
             return cell }
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picked4UCell", for: indexPath) as! HomeCollectionViewCell
         let picked = pickedArray[indexPath.row]
         cell.setupCell(uuid: picked.uuid)
         return cell
    }

    struct categoriesItems {
        let uuid: String
    }
    
    struct featuredItems {
        let uuid: String
    }
    
    struct pickedItems {
        let uuid: String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !LoginPresented {
            prompatToLoginIfNeeded(segueIdentifier: "LoginSegue")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        picked4uCollectionView.delegate = self
        picked4uCollectionView.dataSource = self
    }
    

    // MARK: - Navigation

    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }



}
