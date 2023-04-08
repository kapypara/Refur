//
//  ItemDetailsViewController.swift
//  Refur
//
//  Created by iOSdev on 07/04/2023.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postLikes: UIButton!
    
    @IBOutlet weak var itemCondition: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemBrand: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    
    
    var post: Post?
    
    // TODO: load user Profile
    var userProfile: Profile?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        Database.Posts.observePost(post: "test") { loadedPost in
            
            self.post = loadedPost
            self.updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView() {
        guard let post = post else { return }
        
        if let image = post.images.first {
            Database.Storage.loadImage(view: postImage, uuid: image)
        }
        
        // why is this a button
        postLikes.setTitle("\(post.likes) Likes", for: .normal)
        
        itemDescription.text = post.item.description
        itemPrice.text = "BHD " + String(post.item.price)
        itemBrand.text = post.item.brand
        
        // this will break in the future
        itemSize.text = (post.item.size as! ClothingSize).rawValue
        
        itemCondition.text = post.item.condition.rawValue
        
    }

}
