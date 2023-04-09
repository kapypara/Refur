//
//  ItemDetailsViewController.swift
//  Refur
//
//  Created by iOSdev on 07/04/2023.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    // MARK: Properties
    var userProfile: Profile?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    
    @IBOutlet weak var userNameInPost: UIButton!
    
    var userPost: Post?
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postLikes: UIButton!
    
    @IBOutlet weak var itemCondition: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemBrand: UILabel!
    @IBOutlet weak var itemSize: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {

        userImage.layer.cornerRadius = userImage.bounds.height / 2
        userImage.clipsToBounds = true
        
        guard let userProfile = userProfile, let userPost = userPost else { return }
        
        Database.Storage.loadImage(view: userImage, uuid: userProfile.picture)
        
        userName.text = userProfile.name
        userHandle.text = userProfile.handle
        
        userNameInPost.setTitle(userProfile.name, for: .normal)
        
        if let image = userPost.images.first {
            Database.Storage.loadImage(view: postImage, uuid: image)
        }
        
        // why is this a button
        postLikes.setTitle("\(userPost.likes) Likes", for: .normal)
        
        itemDescription.text = userProfile.name + " " + userPost.item.description
        itemPrice.text = "BHD " + String(userPost.item.price)
        itemBrand.text = userPost.item.brand
        
        // this will break in the future
        itemSize.text = (userPost.item.size as! ClothingSize).rawValue
        
        itemCondition.text = userPost.item.condition.rawValue
        
    }

}