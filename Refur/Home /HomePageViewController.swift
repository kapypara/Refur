//
//  HomePageViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        // debug
        
        User.user.signOut() { state in
            if state {
                print("we just logged out")
                
                if !User.user.isLoggedIn || true {
                    
                    performSegue(withIdentifier: "LoginSegue", sender: nil)
                }
                
            } else {
                print("we did not")
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }


}
