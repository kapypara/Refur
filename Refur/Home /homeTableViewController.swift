//
//  homeTableViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 09/04/2023.
//

import UIKit

class homeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Outlets
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var picked4uCollectionView: UICollectionView!
    
    var selectedPost = ""
    
    let categoriesArray = [
      "other1",
      "book1",
      "other3",
      "clothes1",
      "other5",
      "clothes4",
      "book7",
      "clothes6",
      "other9",
      "other10",
    ]
    
    let featuredArray = [
      "clothes6",
      "other8",
      "other2",
      "book7",
      "clothes4",
    ]
    
    let pickedArray = [
      "book1",
      "book5",
      "book3",
      "book8",
      "book10",
      "book2",
      "book4",
      "book7",
      "book9",
    ]
    
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
    

    // MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoriesCollectionView:
            return categoriesArray.count
            
        case featuredCollectionView:
            return featuredArray.count
            
        default: //picked4uCollectionView
            return pickedArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case categoriesCollectionView:
            selectedPost = categoriesArray[indexPath.row]
            
        case featuredCollectionView:
            selectedPost = featuredArray[indexPath.row]
            
        default: //picked4uCollectionView
            selectedPost = pickedArray[indexPath.row]
        }
        
        
        performSegue(withIdentifier: "showDetails", sender: self)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoriesCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! HomeCollectionViewCell
            
            let categorieslet = categoriesArray[indexPath.row]
            Database.Posts.getPost(post: categorieslet) { loadedPost in
                
                guard let post = loadedPost else { return }
                cell.setupCell(post: post)
                
                AppCache.cachePost(post: post)
            }
            
        return cell
            
        case featuredCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! HomeCollectionViewCell
            
            let featured = featuredArray[indexPath.row]
            Database.Posts.getPost(post: featured) { loadedPost in
                
                guard let post = loadedPost else { return }
                cell.setupCell(post: post)
                
                AppCache.cachePost(post: post)
            }
            
            return cell
            
        default: //picked4uCollectionView
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picked4UCell", for: indexPath) as! HomeCollectionViewCell
            
            let picked = pickedArray[indexPath.row]
            Database.Posts.getPost(post: picked) { loadedPost in
                
                guard let post = loadedPost else { return }
                cell.setupCell(post: post)
                
                AppCache.cachePost(post: post)
            }
            
            return cell
        }
    }
    
    
    // MARK: - Navigation
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

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
