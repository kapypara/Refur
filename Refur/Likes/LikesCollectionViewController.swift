//
//  LikesCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class LikesCollectionViewController: UICollectionViewController {

    var arrayLikes: [Post] = []
   
    let profile = Profile(name: "big man", handle: "BigStuff", picture: "bday.png")

     
     override func viewDidLoad() {
         super.viewDidLoad()
         collectionView.delegate = self
         collectionView.dataSource = self
         
         Database.Users.observeUser(user: "Gigi") { userProfile in
             guard let userProfile = userProfile else { return }
             
             for post in userProfile.posts {
                 Database.Posts.observePost(post: post) { post in
                     if let post = post {
                         self.arrayLikes.append(post)
                         self.collectionView.reloadData()
                     }
                 }
             }
         }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let viewController = segue.destination as? ItemDetailsViewController else { return }
            
            viewController.userProfile = profile
            viewController.userPost = arrayLikes[0]
        }
    }


}
