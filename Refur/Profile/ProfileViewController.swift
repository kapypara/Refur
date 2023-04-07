//
//  ProfileViewController.swift
//  Refur
//
//  Created by iOSdev on 07/04/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        //prompatToLoginIfNeeded(segueIdentifier: "LoginSegue")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        unwindIfNotLoggedIn(segueIdentifier: "Home")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOut(_ sender: Any) {
        User.signOut() { wasSuccessful in
            if wasSuccessful {
                self.unwindIfNotLoggedIn(segueIdentifier: "Home")
            }
        }
    }
    

}
