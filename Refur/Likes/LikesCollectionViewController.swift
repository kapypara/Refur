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
    
    var postArray: [Post] = []
    var profileDict: [String: Profile] = [:]
    
    var selectedPostIndex: Int = 0
    
    var userUid: String?
    var likesHandler: UInt?
    
    
    // MARK: ViewController Fucntions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard User.isLoggedIn else {
            unwindIfNotLoggedIn(segueIdentifier: "Home")
            return
        }
            
        if let user = userUid, user != User.uid! {
            Database.removeObserver(withHandle: likesHandler)
            
            userUid = nil
        }
        
        guard userUid == nil else { return }
        
        userUid = User.uid!
        
        populatePostArray()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: Load Likes
    func populatePostArray() {
        
        likesHandler = Database.Users[User.uid! + "/Likes"].observe(.value) { [self] snapshot in
            
            guard let likes = snapshot.value as? [String] else { return }
            
            postArray.removeAll()
            
            let dummyPost = Post(item: Item.Other(name: "", description: "", condition: .GoodCondition, price: 0.0, type: .Other), images: [""])
            
            for _ in 0 ..< likes.count {
                postArray.append(dummyPost)
            }
            
            for (i, post) in likes.enumerated() {
                Database.Posts.getPost(post: post) { [self] post in
                    guard let post = post else { return }
                    
                    // at this step we have a newe post to display
                    postArray[i] = post
                    
                    
                    // if we find a new user that is not in the dict we added to it
                    guard self.profileDict[post.userUuid] == nil else { return }
                    Database.Users.getUser(user: post.userUuid) { [self] loadedProfile in
                        if let profile = loadedProfile {
                            
                            self.profileDict[post.userUuid] = profile
                            collectionView.reloadData()
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
        
        guard let imageString = likedPost.images.first, !imageString.isEmpty else {
            return cell
        }
        
        guard
            let LikedPostPoster = self.profileDict[likedPost.userUuid]
        else {
            cell.setupCell(post: likedPost)
            return cell
        }
        
        cell.setupCell(post: likedPost, profile: LikedPostPoster)
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
