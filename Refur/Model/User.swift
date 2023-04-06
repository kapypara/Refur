
import Firebase
// this Class provide binding with FirebaseAuth
// note that the User login is persistent

// this class will privately init,
// and should be only used with User.user to access the user instance

typealias CompletionHandler = (_ wasSuccessful:Bool) -> Void

// TODO: make user login persistent
// the user might inherit from profile class
class User {

    static let user = User()

    //private override init() { }
    private init() { }
    
    // TODO: check if user this work
    var isLoggedIn: Bool { return FirebaseAuth.Auth.auth().currentUser != nil }

    var uid: String? { return FirebaseAuth.Auth.auth().currentUser?.uid }

    func signOut(completionHandler: CompletionHandler = {(_) -> Void in ()}) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            completionHandler(true)
            // UserDefaults.standard.removeObject(forKey: "user_uid_key")
        } catch {
            print("Error signing out")
            completionHandler(false)
        }
    }

    // TODO: Add more login methods
    func signIn(email: String, password: String, completionHandler: @escaping CompletionHandler = {(_) -> Void in ()}) {
        FirebaseAuth.Auth.auth().signIn(
                withEmail: email,
                password: password,
                completion: { [weak self] result, error in
            
                    guard error == nil else {

                        print("invalid credentials ", error ?? "")
                        
                        completionHandler(false)
                        return
                    }

                    completionHandler(true)
        })
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping CompletionHandler = {(_) -> Void in ()}) {
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            
            guard error == nil else {
                
                print("SignUp failed ", error ?? "")
                
                completionHandler(false)
                return
            }

            completionHandler(true)
        })
        
    }
        

}
