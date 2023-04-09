import UIKit

import FirebaseDatabase
import FirebaseStorage


typealias PostCompletionHandler = (_ loadedPost: Post?) -> Void
typealias ProfileCompletionHandler = (_ loadedPost: Profile?) -> Void


class Database {
    
    static let DataBaseRef = FirebaseDatabase.Database.database(url: "https://refur-2a2f0-default-rtdb.firebaseio.com/").reference()
    
    static let StorageRef = FirebaseStorage.Storage.storage(url: "gs://refur-2a2f0.appspot.com/").reference()

    
    class Users {
        
        static var users = DataBaseRef.child("users")
        
        static var currentUser: DatabaseReference { DataBaseRef.child(User.uid!) }
        
        static subscript (uuid: String) -> DatabaseReference {
            return Database.Users.users.child(uuid)
        }
        
        static func observeUser(user: String, completionHandler: @escaping ProfileCompletionHandler = {(_) -> Void in ()},_ eventType: DataEventType = .value) {
            
            Database.Users[user].observe(eventType) { snapshot in
                
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
    }
    
    class Posts {
        
        static var posts = DataBaseRef.child("posts")
        
        static subscript (uuid: String) -> DatabaseReference {
            return Database.Posts.posts.child(uuid)
        }
        
        static func observePost(post: String, completionHandler: @escaping PostCompletionHandler = {(_) -> Void in ()},_ eventType: DataEventType = .value) {
            
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
    }
    
    
    class Storage {
                
        static func saveImage(image: UIImage) -> String? {
            
            guard let imageData = image.pngData() else { return nil }
            
            var imageUuid: String? = UUID().uuidString
            
            StorageRef.child("images/\(imageUuid!)").putData(imageData, metadata: nil, completion: { _, error in
                
                guard error == nil else {
                    print("Failed to upload", error ?? "")
                    
                    imageUuid = nil
                    return
                }
            })
            
            return imageUuid
        }
        
        static func loadImage(view: UIImageView, uuid: String) {
            
            StorageRef.child("images/\(uuid)").getData(maxSize:(104857666), completion: { (data, error) in
                
                guard error == nil else {
                    print("Failed to download", error ?? "")
                    return
                }
                
                if let image = data {
                    view.image = UIImage(data: image)
                }
            })
        }
    }
    
    
    private init() { }
    
}
