//
//  ProfileViewController.swift
//  Refur
//
//  Created by iOSdev on 07/04/2023.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userHnadle: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var soldItems: UILabel!
    
    var observeHandle: UInt = 0
    
    var postArray: [Post] = [] {
        didSet {
            profilePostsCollectionView.reloadData()
        }
    }
    var profileDict: [String: Profile] = [:]
    
    var selectedPostIndex: Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //prompatToLoginIfNeeded(segueIdentifier: "LoginSegue")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        userImage.layer.cornerRadius = userImage.bounds.height / 2
        userImage.clipsToBounds = true
        
        if User.isLoggedOut {
            unwindIfNotLoggedIn(segueIdentifier: "Home")
        } else {
            loadUser()
            loadPosts()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.removeObserver(withHandle: observeHandle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePostsCollectionView.delegate = self
        profilePostsCollectionView.dataSource = self

    }
    
    func loadUser() {
        observeHandle = Database.Users.observeUser(user: User.uid!) { loadedProfile in
            
            guard let profile = loadedProfile else { return }
            
            Database.Storage.loadImage(view: self.userImage, uuid: profile.picture)
            
            self.username.text = profile.name
            self.userHnadle.text = "@" + profile.handle
            
            self.userBio.text = profile.bio
            self.soldItems.text = "Sold: " + "\(profile.soldItems)"
        }
    }
    
    
    
    @IBAction func signOut(_ sender: Any) {
        User.signOut() { wasSuccessful in
            if wasSuccessful {
                self.unwindIfNotLoggedIn(segueIdentifier: "Home")
            }
        }
    }
    
    // MARK: POSTS
    @IBOutlet weak var profilePostsCollectionView: UICollectionView!
    
    func loadPosts() {
        
        Database.Users[User.uid! + "/Posts"].observe(.value) { snapshot in
            
            guard let posts = snapshot.value as? [String] else { return }
            print(posts)
            
            self.postArray.removeAll()
            //print(self.postArray.count)
            
            //print(userProfile.posts)
            
            for post in posts {
                Database.Posts.observePost(post: post) { post in
                    guard let post = post else { return }
                    
                    // at this step we have a newe post to display
                    self.postArray.append(post)
                    
                    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
   }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPostIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilePostCell", for: indexPath) as! ProfilePostsCollectionViewCell
        
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
