//
//  LikesCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

private var loadedPost = false

class LikesCollectionViewController: UICollectionViewController {
    
    var postArray: [Post] = []
    var profileDict: [String: Profile] = [:]
    
    var selectedPostIndex: Int = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if User.isLoggedOut {
            unwindIfNotLoggedIn(segueIdentifier: "toHome")
        } else {
            populatePostArray()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func populatePostArray() {
        
        guard !loadedPost else { return }
        loadedPost = true
        
        Database.Users.observeUser(user: User.uid!) { userProfile in
            guard let userProfile = userProfile else { return }
            
            self.postArray = []
            
            for post in userProfile.posts {
                Database.Posts.observePost(post: post) { post in
                    if let post = post {
                        
                        // at this step we have a newe post to display
                        self.postArray.append(post)
                        self.collectionView.reloadData()
                        
                        
                        // if we find a new user that is not in the dict we added to it
                        guard self.profileDict[post.userUuid] == nil else { return }
                        Database.Users.observeUser(user: post.userUuid) { loadedProfile in
                            if let profile = loadedProfile {
                                
                                self.profileDict[post.userUuid] = profile
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: CollectionView Functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return postArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPostIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikesCell", for: indexPath) as! CategoriesCollectionViewCell
        
        // Configure the cell
        let likes = postArray[indexPath.row]
        
        cell.setupCall(post: likes)
        return cell
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let viewController = segue.destination as? ItemDetailsViewController else { return }
            
            let post = postArray[selectedPostIndex]
            
            viewController.userPost = post
            viewController.userProfile = profileDict[post.userUuid]
        }
    }
    
    
}
