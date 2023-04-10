//
//  ProfileViewController.swift
//  Refur
//
//  Created by iOSdev on 07/04/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userHnadle: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var soldItems: UILabel!
    
    var observeHandle: UInt = 0
    
    
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
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.removeObserver(withHandle: observeHandle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

}
