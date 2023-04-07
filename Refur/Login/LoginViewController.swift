//
//  LoginViewController.swift
//  Refur
//
//  Created by Hasan Almadhoob on 26/03/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.setupLeftImageView(image: UIImage(systemName: "envelope")!)
        passwordTextField.setupLeftImageView(image: UIImage(systemName: "lock")!)
        
        updateSignInButton()
    }
    
    func updateSignInButton() {
        guard
            let emailIsEmpty = emailTextField.text?.isEmpty,
            let passwordIsEmpty = passwordTextField.text?.isEmpty,
            !emailIsEmpty && !passwordIsEmpty
        else {
            signInButton.isEnabled = false
            return
        }
        
        signInButton.isEnabled = true
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty
        else {
            return
        }
        
        registerButton.isEnabled = false
        signInButton.isEnabled = false
        
        User.signIn(email: email, password: password) { wasSucsseful in
            
            self.registerButton.isEnabled = true
            self.signInButton.isEnabled = true
            self.passwordTextField.text = ""
            
            if !wasSucsseful {
                // TODO: make this more user freindly
                let alert = UIAlertController(
                    title: "Invalid Credentials",
                    message: "Invalid Credentials, please tryy again",
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                
                self.present(alert, animated: true)
                
            } else {
                print("log in was susscful")
                self.performSegue(withIdentifier: "SignInToHome", sender: self)
            }
        }

    }
    
    @IBAction func fieldModified(_ sender: UITextField) {
        updateSignInButton()
    }
    
    
    
}
