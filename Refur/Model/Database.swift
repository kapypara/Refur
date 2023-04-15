import UIKit

import FirebaseDatabase
import FirebaseStorage

import Kingfisher

typealias PostCompletionHandler = (_ loadedPost: Post?) -> Void
typealias ProfileCompletionHandler = (_ loadedPost: Profile?) -> Void
typealias StringCompletionHandler = (_ loadedString: String?) -> Void
typealias UIImageCompletionHandler = (_ loadedString: UIImage?) -> Void

class Database {
    
    static let DataBaseRef = FirebaseDatabase.Database.database(url: "https://refur-2a2f0-default-rtdb.firebaseio.com/").reference()
    
    static let StorageRef = FirebaseStorage.Storage.storage(url: "gs://refur-2a2f0.appspot.com/").reference()

    
    static func removeObserver(withHandle: UInt) {
        Database.DataBaseRef.removeObserver(withHandle: withHandle)
    }
    
    class Users {
        
        static var users = DataBaseRef.child("users")
        
        static var currentUser: DatabaseReference { DataBaseRef.child(User.uid!) }
        
        static subscript (uuid: String) -> DatabaseReference {
            return Database.Users.users.child(uuid)
        }
        
        static func observeUser(user: String, completionHandler: @escaping ProfileCompletionHandler = {(_) -> Void in ()},_ eventType: DataEventType = .value) -> UInt {
            
            return Database.Users[user].observe(eventType) { snapshot in
                
                guard
                    snapshot.value != nil,
                    let result = snapshot.value! as? [String: Any]
                else {
                    
                    completionHandler(nil)
                    return
                }
                
                let loadedProfile = Profile.loadProfile(dictionary: result)
                
                completionHandler(loadedProfile)
            }
        }
        
        static func getUser(user: String, completionHandler: @escaping ProfileCompletionHandler = {(_) -> Void in ()},_ eventType: DataEventType = .value) {
            
            Database.Users[user].getData { error, snapshot in
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                guard
                    let result = snapshot?.value as? [String: Any]
                else {
                    completionHandler(nil)
                    return
                }
                
                let loadedProfile = Profile.loadProfile(dictionary: result)
                
                completionHandler(loadedProfile)
            }
        }
    }
    
    class Posts {
        
        static var posts = DataBaseRef.child("posts")
        
        static subscript (uuid: String) -> DatabaseReference {
            return Database.Posts.posts.child(uuid)
        }
        
        static func observePost(post: String, completionHandler: @escaping PostCompletionHandler = {(_) -> Void in ()}, eventType: DataEventType = .value) {
            
            Database.Posts[post].observe(eventType) { snapshot in
                
                guard
                    snapshot.value != nil,
                    let result = snapshot.value! as? [String: Any]
                else {
                    
                    completionHandler(nil)
                    return
                }
                
                let loadedPost = Post.loadPost(uuid: post, dictionary: result)
                
                completionHandler(loadedPost)
            }
        }
        
        static func getPost(post: String, completionHandler: @escaping PostCompletionHandler) {
            
            Database.Posts[post].getData { error, snapshot in
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                guard
                    let result = snapshot?.value as? [String: Any]
                else {
                    completionHandler(nil)
                    return
                }
                
                let loadedPost = Post.loadPost(uuid: post, dictionary: result)
                
                completionHandler(loadedPost)
            }
        }
        
    }
    
    
    class Storage {

        // MARK: Images
        static func saveImage(image: UIImage, completionHandler: @escaping StringCompletionHandler) {
            
            guard
                let imageData = image.jpegData(compressionQuality: 0.95)
            else {
                completionHandler(nil)
                return
            }
            
            let imageUuid = UUID().uuidString
            
            StorageRef.child("images/\(imageUuid)").putData(imageData, metadata: nil) { _, error in
                
                guard error == nil else {
                    print("Failed to upload", error ?? "")
                    
                    completionHandler(nil)
                    return
                }

                completionHandler(imageUuid)
            }
        }
        
        static func loadImage(view: UIImageView, uuid: String) {
            
            StorageRef.child("images/\(uuid)").downloadURL { url, error in
                
                guard error == nil else {
                    print("Failed to download", error ?? "")
                    return
                }
                
                guard let url = url else { return }
                view.kf.setImage(with: url)
            }
        }
    }
    
    
    private init() { }
    
}
