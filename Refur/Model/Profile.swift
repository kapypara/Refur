import UIKit

class Profile {

    var name: String
    var handle: String
    
    var picture: String
    
    var bio: String

    var soldItems: Int
    
    var likes: [String] // posts uuid
    var posts: [String] // also posts uuid
    
    struct ContactInfo {
        var address: String
        var email: String
        var phoneNumber: Int
    }
    
    var contactInfo: ContactInfo
    
    init(name: String, handle: String,
         picture: String = "", bio: String = "",
         contact: ContactInfo = ContactInfo(address: "", email: "", phoneNumber: 0),
         soldItems: Int = 0, posts: [String] = [], likes: [String] = []) {
        
        self.name = name
        self.handle = handle
        
        self.picture = picture
        self.bio = bio
        
        contactInfo = contact
        
        self.soldItems = soldItems
        
        self.posts = posts
        self.likes = likes
    }
    
    
    static func loadProfile(dictionary: [String: Any]) -> Profile? {
        
        guard
            let name = dictionary["Name"] as? String,
            let handle = dictionary["Handle"] as? String
        else {
            print("[Profile.loadProfile] error parsing Poast, dumping dict", dictionary)
            return nil
        }
        
        let picture = dictionary["Image"] as? String ?? ""
        let bio = dictionary["Bio"] as? String ?? "insert Descripition"
        
        let soldItems = dictionary["SoldItems"] as? Int ?? 0
        
        let contactDict = dictionary["ContactInfo"] as? [String: Any] ?? [:]
        
        let address = contactDict["Address"] as? String ?? ""
        let email = contactDict["Email"] as? String ?? ""
        let phoneNumber = contactDict["PhoneNumber"] as? Int ?? 0
        
            
        let posts = dictionary["Posts"] as? [String] ?? []
            
        let likes = dictionary["Likes"] as? [String] ?? []
        
        let contactInfo = ContactInfo(address: address, email: email, phoneNumber: phoneNumber)
        
        //print(dictionary)
        //print(name, handle, picture, bio, contactInfo, posts, posts, likes)
        
        return Profile(name: name, handle: handle, picture: picture, bio: bio, contact: contactInfo, soldItems: soldItems, posts: posts, likes: likes)
    }
    
    static func saveProfile(uuid: String, profile: Profile) {
        
        Database.Users[uuid].setValue([
            "Bio": profile.bio,
            "ContactInfo": [
                "Address": profile.contactInfo.address,
                "Email": profile.contactInfo.email,
                "PhoneNumber": profile.contactInfo.phoneNumber
            ],
            "Handle": profile.handle,
            "Image": profile.picture,
            "Likes": profile.likes,
            "Name": profile.name,
            "Posts": profile.posts,
            "SoldItems": profile.soldItems
        ])
    }
    
}
