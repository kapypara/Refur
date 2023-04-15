//
//  OthersCategoryCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 03/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class OthersCategoryCollectionViewController: UICollectionViewController {
    
    var selectedPost = ""
    
    let arrayOthers = [
        "other1",
        "other2",
        "other3",
        "other4",
        "other5",
        "other6",
        "other7",
        "other8",
        "other9",
        "other10"
    ]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOthers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedPost = arrayOthers[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OthersCell", for: indexPath) as! CategoriesCollectionViewCell
        
        let other = arrayOthers[indexPath.row]
        
        guard
            let post = AppCache.getPost(postUuid: other),
            let profile = AppCache.getProfile(profileUuid: post.postUuid)
        else {
            
            Database.Posts.getPost(post: other) { loadedPost in
                
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
