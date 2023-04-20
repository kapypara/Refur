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
        
    
    @IBOutlet weak var ClothesStack: UIStackView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var isItemAdded: Bool = false {
        didSet {
            addToCartButton.isEnabled = isItemAdded
            addToCartButton.setTitle(isItemAdded ? "ADD TO CART" : "ADDED TO CART", for: .normal)
        }
    }
    
    var isItemLiked: Bool = false {
        didSet {
            likeButton.setImage(
                UIImage(systemName: (isItemLiked ? "heart.fill" : "heart"))!,
                for: .normal)
        }
    }
    
    var likesHandler: UInt?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let post = userPost {
            Database.Posts[post.postUuid + "/Likes"].setValue(post.likes+1)
        }
        updateView()
        updateAddButton()
        updateLikeButton() // this only need to be called once
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Database.removeObserver(withHandle: likesHandler)
    }
    
    func updateView() {

        userImage.layer.cornerRadius = userImage.bounds.height / 2
        userImage.clipsToBounds = true
        
        guard let userProfile = userProfile, let userPost = userPost else { return }
        
        Database.Storage.loadImage(view: userImage, uuid: userProfile.picture)
        
        userName.text = userProfile.name
        userHandle.text = "@" + userProfile.handle
        
        userNameInPost.setTitle(userProfile.name, for: .normal)
        
        if let image = userPost.images.first {
            Database.Storage.loadImage(view: postImage, uuid: image)
        }
        
        // why is this a button... I Kinda know but I wont tell :P
        postLikes.setTitle("\(userPost.likes) Likes", for: .normal)
        
        itemDescription.text = userProfile.name + " " + userPost.item.description
        itemPrice.text = String(format: "BHD %.2f", userPost.item.price)
        
        switch userPost.item.category {
        case .Clothing:
            itemSize.text = (userPost.item.size as! ClothingSize).rawValue
            itemBrand.text = userPost.item.brand
            
        default:
            ClothesStack.isHidden = true
        }
        
        itemCondition.text = userPost.item.condition.rawValue
    }

    func updateAddButton() {
        
        guard let userPost = userPost else { return }
        
        for i in Cart.cart {
            if userPost.postUuid == i.item.postUuid {
                isItemAdded = false
                return
            }
        }
        
        isItemAdded = true
    }
    
    func updateLikeButton() {
        
        guard let uid = User.uid else { likeButton.isEnabled = false; return }
        
        
        likesHandler = Database.Users[uid + "/Likes"].observe(.value) { [self] snapshot in
            
            guard let result = snapshot.value as? [String] else { return }
            
            for i in result {
                if i == userPost?.postUuid {
                    isItemLiked = true
                    return
                }
            }
            
            isItemLiked = false
        }
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        
        guard let userPost = userPost else { return }

        Cart.addToCart(itemPost: userPost)
        updateAddButton()
    }
    
    @IBAction func likePost(_ sender: UIButton) {
        
        guard let uid = User.uid, let userPost = userPost else { return }
        
        isItemLiked.toggle()
        
        Database.Users[uid + "/Likes"].getData() { [self] error, snapshot in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let result = snapshot?.value as? [String] else { return }
            
            var filtered = result.filter() { userPost.postUuid != $0 }
            
            if isItemLiked {
                filtered.append(userPost.postUuid)
            }
            
            Database.Users[uid + "/Likes"].setValue(filtered)
        }
    }
}
