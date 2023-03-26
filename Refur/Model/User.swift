
import FirebaseAuth

// this Class provide binding with FirebaseAuth

// this class will privately init,
// and should be only used with User.user to access the user instance


// TODO: make user login persistent
// the user might inherit from profile class
class User {

    static let user = User()

    private override init() { }

    // TODO: check if user this work
    var loggedIn: Bool { return firebase.auth().currentUser != nil }


    func signOut(_ sender: Any) -> Bool {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            // UserDefaults.standard.removeObject(forKey: "user_uid_key")

            return true

        } catch {
            print("Error signing out")
        }

        return false
    }

    // TODO: Add more login methods
    func signIn(username: String, password: String) -> Bool {
        FirebaseAuth.Auth.auth().signIn(
                withEmail: username,
                password: password,
                completion: { [weak self] result, error in

                    guard let self = self else { return }
            
                    guard error == nil else {

                        // print("invalid credentials ")

                        let alert = UIAlertController(
                                title: "Invalid Credentials",
                                message: "Invalid Credentials, please tryy again",
                                preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "ok", style: .cancel))

                        self.present(alert, animated: true)
                        return false
                    }

                    // UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
                    // self.performSegue(withIdentifier: "home", sender: sender)
                    return true
        })
    }
}
