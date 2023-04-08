//
//  Controller.swift
//  Refur
//
//  Created by iOSdev on 07/04/2023.
//

import UIKit

var LoginPresented = false

extension UIViewController {
    func prompatToLoginIfNeeded(segueIdentifier: String) {
        if User.isLoggedOut {
            LoginPresented = true
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }
    
    
    func unwindIfNotLoggedIn(segueIdentifier: String) {
        if User.isLoggedOut {
            LoginPresented = false
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }
}
