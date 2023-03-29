import UIKit

class Profile {

    var name: String
    var handle: String
    
    var picture: UIImage
    
    var bio: String

    var soldItems: Int
    
    init(name: String, handle: String, picture: UIImage, bio: String, soldItems: Int = 0) {
        self.name = name
        self.handle = handle
        self.picture = picture
        self.bio = bio
        self.soldItems = soldItems
    }
}
