//
//  ProfileViewController.swift
//  Refur
//
//  Created by iOSdev on 07/04/2023.
//

import UIKit
import AVFoundation

private var loadedProfile = false
private var loadedPosts = false

class ProfileViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userHnadle: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var soldItems: UILabel!
    
    @IBOutlet weak var usernameStack: UIStackView!
    
    var cameraAuthorization: AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    var postArray: [Post] = [] {
        didSet {
            profilePostsCollectionView.reloadData()
        }
    }

    var profileDict: [String: Profile] = [:]
    
    var selectedPostIndex: Int = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePostsCollectionView.delegate = self
        profilePostsCollectionView.dataSource = self
        
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        
        userImage.addGestureRecognizer(profileImageTap)
        userImage.isUserInteractionEnabled = true
        
        let usernameTap = UITapGestureRecognizer(target: self, action: #selector(changeUsername))
        
        usernameStack.addGestureRecognizer(usernameTap)
        usernameStack.isUserInteractionEnabled = true
    }
    
    @objc func changeUsername() {
        let alert = UIAlertController(title: "Edit Name", message: "Enter new Your Name", preferredStyle: .alert)
        
        
        alert.addTextField() { (textField) -> Void in
            textField.text = self.username.text!
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak alert] (action) -> Void in
            if let text = alert?.textFields?.first?.text as? String {
                //print("Text field: \(textField.text!)")
                
                Database.Users[User.uid! + "/Name"].setValue(text)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // MARK: Profile Picture
    @objc func changeProfilePicture() {
        
        Task {
            if cameraAuthorization == .notDetermined {
                await AVCaptureDevice.requestAccess(for: .video)
            }
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            if cameraAuthorization == .authorized {
                actionSheet.addAction(UIAlertAction(title: "Camera", style: .default) { alert in
                    self.present(self.cameraPickerController, animated: true)
                })
            }
            
            actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default) { alert in
                self.present(self.photoLibraryPickerController, animated: true)
            })
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    var cameraPickerController: UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = self;
        controller.sourceType = .camera
        controller.allowsEditing = true
        
        return controller
    }
    
    var photoLibraryPickerController: UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = self;
        controller.sourceType = .photoLibrary
        controller.allowsEditing = true
        
        return controller
    }

    func saveProfilePicture() {
        Database.Storage.saveImage(image: userImage.image!) { imageUid in
            
            guard let imageUid = imageUid else { return }
            
            Database.Users[User.uid! + "/Image"].setValue(imageUid)
        }
    }

    
    @IBAction func editProfile(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Edit Profile", message: "Enter new Your Bio", preferredStyle: .alert)
        
        
        alert.addTextField() { (textField) -> Void in
            textField.text = self.userBio.text!
            
            //let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
            //textField.addConstraint(heightConstraint)
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak alert] (action) -> Void in
            if let text = alert?.textFields?.first?.text as? String {
                //print("Text field: \(textField.text!)")
                
                Database.Users[User.uid! + "/Bio"].setValue(text)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    

    @IBAction func signOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "are you sure you want to logout", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
            User.signOut() { wasSuccessful in
                if wasSuccessful {
                    self.unwindIfNotLoggedIn(segueIdentifier: "Home")
                }
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
    // MARK: Loading Data
    func loadUser() {
        
        guard !loadedProfile else { return }
        loadedProfile = true
        
        let _ = Database.Users.observeUser(user: User.uid!) { loadedProfile in
            
            guard let profile = loadedProfile else { return }
            
            Database.Storage.loadImage(view: self.userImage, uuid: profile.picture)
            
            self.username.text = profile.name
            self.userHnadle.text = "@" + profile.handle
            
            self.userBio.text = profile.bio
            self.soldItems.text = "Sold: " + "\(profile.soldItems)"
        }
    }
    
    // MARK: POSTS
    @IBOutlet weak var profilePostsCollectionView: UICollectionView!
    
    func loadPosts() {
        
        guard !loadedPosts else { return }
        loadedPosts = true
        
        Database.Users[User.uid! + "/Posts"].observe(.value) { snapshot in
            
            guard let posts = snapshot.value as? [String] else { return }
            
            self.postArray.removeAll()
            
            for post in posts {
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
    
    // MARK: Collection View
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
        cell.setupCell(post: postArray[indexPath.item])
        
        return cell
    }
    
    // MARK: Picker Controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]
            
        if let image = image as? UIImage {
            userImage.image = image
        }
        
        saveProfilePicture()
        picker.dismiss(animated: true, completion: nil)
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
