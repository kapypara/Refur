//
//  SignUpTableViewController.swift
//  Refur
//
//  Created by iOSdev on 06/04/2023.
//

import UIKit

class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var eamilTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var aggrementButton: UIButton!
    
    var didAgree: Bool = false {
        didSet {
            aggrementButton.isSelected = didAgree
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateRegisterButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100 //keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func updateRegisterButton() {
        guard
            let emailIsEmpty = eamilTextField.text?.isEmpty,
            !emailIsEmpty,
            let usernameIsEmpty = usernameTextField.text?.isEmpty,
            !usernameIsEmpty,
            let passwordIsEmpty = passwordTextField.text?.isEmpty,
            !passwordIsEmpty,
            let rePeatPasswordIsEmpty = reEnterPasswordTextField.text?.isEmpty,
            !rePeatPasswordIsEmpty,
            didAgree
        else {
            registerButton.isEnabled = false
            return
        }
        
        registerButton.isEnabled = true
    }
    
    @IBAction func FieldChanged(_ sender: Any) {
        updateRegisterButton()
    }
    
    
    @IBAction func agreeButtonPressed(_ sender: Any) {
        didAgree.toggle()
        updateRegisterButton()
    }
    
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        guard
            let email = eamilTextField.text,
            let username = usernameTextField.text,
            let password = passwordTextField.text,
            let passwordrebeat = reEnterPasswordTextField.text
        else {
            return
        }
        
        guard password == passwordrebeat else {
            let alert = UIAlertController(
                title: "passowrds does not matchs",
                message: "please reinput password",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .cancel))
            
            self.present(alert, animated: true)
            return
        }
        
        registerButton.isEnabled = false
        
        User.signUp(email: email, password: password) { signUpWasSucessful in
            
            self.registerButton.isEnabled = true
            self.reEnterPasswordTextField.text = ""
            self.passwordTextField.text = ""
            
            if signUpWasSucessful {
                
                User.signIn(email: email, password: password) { loginWasSucessful in
                    
                    if loginWasSucessful {
                        
                        let newUserProfile = Profile(name: username, handle: username)
                        
                        newUserProfile.contactInfo.email = email
                        
                        Profile.saveProfile(uuid: User.uid ?? "Gust", profile: newUserProfile)
                        
                        self.performSegue(withIdentifier: "SignUpToHome", sender: self)
                        
                    } else {
                        let alert = UIAlertController(
                            title: "Can't Login",
                            message: "please try to Login speratly",
                            preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                        self.present(alert, animated: true)
                    }
                }
                
            } else {
                // TODO: write a better message
                let alert = UIAlertController(
                    title: "Invalid Credentials",
                    message: "Invalid Credentials, please tryy again",
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    
    @IBAction func nextField(_ sender: UITextField) {
        
        switch sender {
        case eamilTextField:
            usernameTextField.becomeFirstResponder()
            
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            reEnterPasswordTextField.becomeFirstResponder()
            
        default: //reEnterPasswordTextField
            sender.resignFirstResponder()
        }
    }
    
}
