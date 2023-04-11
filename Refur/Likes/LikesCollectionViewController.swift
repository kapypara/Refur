//
//  LikesCollectionViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

private var loadedPost = false

private let LikesQueue = DispatchQueue(label: "Likes.serial.queue")

class LikesCollectionViewController: UICollectionViewController {
    
    var postArray: [Post] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
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
        
        Database.Users[User.uid! + "/Likes"].observe(.value) { snapshot in
            
            guard let likes = snapshot.value as? [String] else { return }
            print(likes)
            
            
            self.postArray.removeAll()
            print(self.postArray.count)
            
            //print(userProfile.posts)
            
            for post in likes {
                Database.Posts.getPost(post: post) { post in
                    guard let post = post else { return }
                    
                    // at this step we have a newe post to display
                    self.postArray.append(post)
                    
                    
                    // if we find a new user that is not in the dict we added to it
                    guard self.profileDict[post.userUuid] == nil else { return }
                    Database.Users.getUser(user: post.userUuid) { loadedProfile in
                        if let profile = loadedProfile {
                            
                            self.profileDict[post.userUuid] = profile
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
        
        let likedPost = postArray[indexPath.row]
        
        guard
            let LikedPostPoster = self.profileDict[likedPost.userUuid]
        else {
            cell.setupCall(post: likedPost)
            return cell
        }
        
        cell.setupCall(post: likedPost, profile: LikedPostPoster)
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
