//
//  BooksCategoryCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 03/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class BooksCategoryCollectionViewController: UICollectionViewController {

    
      var arrayBooks: [booksItems] = [
        booksItems(booksLabel: "@hash", uuid: "books1.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "book2.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "books3.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "books4.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "books5.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "books7.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "books8.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "books9.jpeg"),
        booksItems(booksLabel: "@hash", uuid: "books10.jpeg"),
       
        
      ]
     

       
       override func viewDidLoad() {
           super.viewDidLoad()
           collectionView.delegate = self
           collectionView.dataSource = self
       }



       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of items
           return arrayBooks.count
       }

       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as! CategoriesCollectionViewCell
       
           // Configure the cell
           let books = arrayBooks[indexPath.row]
           cell.setupCell(uuid: books.uuid, label: books.booksLabel)
           return cell
       }

       struct booksItems {
           let booksLabel : String
           
           // debug
           let uuid: String
       }


}
