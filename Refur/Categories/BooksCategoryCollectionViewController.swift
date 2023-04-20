//
//  BooksCategoryCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 03/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class BooksCategoryCollectionViewController: UICollectionViewController {
    
    let arrayBooks = [
        "book2",
        "book10",
        "book3",
        "book4",
        "book5",
        "book6",
        "book7",
        "book8",
        "book9",
        "book1"

    ]
    
    
    var selectedPost = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayBooks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedPost = arrayBooks[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCell", for: indexPath) as! CategoriesCollectionViewCell
        
        let book = arrayBooks[indexPath.row]
        
        guard
            let post = AppCache.getPost(postUuid: book),
            let profile = AppCache.getProfile(profileUuid: post.postUuid)
        else {
            
            Database.Posts.getPost(post: book) { loadedPost in
                
                guard let post = loadedPost else { return }
                
                AppCache.cachePost(post: post, postOnly: true)
                
                Database.Users.getUser(user: post.userUuid) { loadedProfile in
                    
                    guard let profile = loadedProfile else { return }
                    
                    AppCache.cacheProfile(profile: profile, uuid: post.userUuid)
                    
                    cell.setupCell(post: post, profile: profile)
                }
            }
            
            return cell
        }
        
        
        cell.setupCell(post: post, profile: profile)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let viewController = segue.destination as? ItemDetailsViewController else { return }
            
            guard
                let post = AppCache.getPost(postUuid: selectedPost),
                let profile = AppCache.getProfile(profileUuid: post.userUuid)
            else {
                return
                
            }
            
            viewController.userPost = post
            viewController.userProfile = profile
        }
        
    }
    
}
