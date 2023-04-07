//
//  HomePageViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        
        if !LoginPresented {
            prompatToLoginIfNeeded(segueIdentifier: "LoginSegue")
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
