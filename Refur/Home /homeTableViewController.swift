//
//  homeTableViewController.swift
//  Refur
//
//  Created by ghufran almoamen  on 09/04/2023.
//

import UIKit

class homeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var picked4uCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var normalHome: UIStackView!
    @IBOutlet weak var SeachCollectionView: UICollectionView!
    
    var isSearchMode: Bool = false {
        didSet {
            if isSearchMode {
                SeachCollectionView.isHidden = false
                normalHome.isHidden = true
            } else {
                SeachCollectionView.isHidden = true
                normalHome.isHidden = false
            }
        }
    }
    
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
    
    var searchResult: [Post] = []
    
    override func viewDidAppear(_ animated: Bool) {
        if !LoginPresented {
            prompatToLoginIfNeeded(segueIdentifier: "LoginSegue")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        picked4uCollectionView.delegate = self
        picked4uCollectionView.dataSource = self
        
        searchBar.delegate = self
        
        SeachCollectionView.delegate = self
        SeachCollectionView.dataSource = self
        
        isSearchMode = false
    }
    

    // MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoriesCollectionView:
            return categoriesArray.count
            
        case featuredCollectionView:
            return featuredArray.count
            
        case picked4uCollectionView:
            return pickedArray.count
            
        default:
            return searchResult.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case categoriesCollectionView:
            selectedPost = categoriesArray[indexPath.row]
            
        case featuredCollectionView:
            selectedPost = featuredArray[indexPath.row]
            
        case picked4uCollectionView:
            selectedPost = pickedArray[indexPath.row]
            
        default:
            selectedPost = searchResult[indexPath.row].postUuid
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
            
        case picked4uCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picked4UCell", for: indexPath) as! HomeCollectionViewCell
            
            let picked = pickedArray[indexPath.row]
            Database.Posts.getPost(post: picked) { loadedPost in
                
                guard let post = loadedPost else { return }
                cell.setupCell(post: post)
                
                AppCache.cachePost(post: post)
            }
            
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as! HomeCollectionViewCell
            
            let picked = searchResult[indexPath.row]
            
            cell.setupCell(post: picked)
            
            return cell
        }
    }
    
    // MARK: Search functoinality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearchMode = !searchText.isEmpty
        
        guard isSearchMode else { return }
        
        searchResult.removeAll()
        
        let _ = AppCache.allItems().map() {
            if $0.item.description.lowercased().contains(searchText.lowercased()) {
                searchResult.append($0)
            }
        }
        
        SeachCollectionView.reloadData()
        print(searchResult)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       view.endEditing(true)
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
