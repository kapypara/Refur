
import Firebase
// this Class provide binding with FirebaseAuth
// note that the User login is persistent

// this class will privately init,
// and should be only used with User.user to access the user instance


// TODO: make user login persistent
// the user might inherit from profile class
class User {

    static let user = User()

    //private override init() { }
    private init() { }
    
    // TODO: check if user this work
    var isLoggedIn: Bool { return FirebaseAuth.Auth.auth().currentUser != nil }

    var uid: String? { return FirebaseAuth.Auth.auth().currentUser?.uid }

    func signOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            // UserDefaults.standard.removeObject(forKey: "user_uid_key")
        } catch {
            print("Error signing out")
        }
    }

    // TODO: Add more login methods
    func signIn(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(
                withEmail: email,
                password: password,
                completion: { [weak self] result, error in
            
                    guard error == nil else {

                        print("invalid credentials ", error ?? "")

                        /*
                        let alert = UIAlertController(
                                title: "Invalid Credentials",
                                message: "Invalid Credentials, please tryy again",
                                preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "ok", style: .cancel))

                        self.present(alert, animated: true)
                        */
                        return
                    }

                    // UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
                    // self.performSegue(withIdentifier: "home", sender: sender)
        })
    }
    
    func signUp(email: String, password: String) -> Bool {
        
        var ret = true
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            
            //guard let self = self else {return}
            
            guard error == nil else {
                
                print("SignUp failed ", error ?? "")
                ret = false
                return
            }
            
            let ref = FirebaseDatabase.Database.database(url: "https://refur-2a2f0-default-rtdb.firebaseio.com/").reference()
            let uid = Auth.auth().currentUser?.uid
            ref.child("users").child(uid!).setValue(["Email" : email, "Name" : password, "TYpe": "user"])
            
        })
        
        return ret
    }
        

}
