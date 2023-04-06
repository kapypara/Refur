//
//  HomePageViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        if !User.user.isLoggedIn {
            
            print("before seg")
            performSegue(withIdentifier: "LoginSegue", sender: nil)
            print("after seg")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
