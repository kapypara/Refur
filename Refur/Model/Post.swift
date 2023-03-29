import UIKit

// Post class should only be called when user is logged in
class Post {

    // owner
    let postUuid: String
    let userUuid: String

    var datePosted: Date
    var dateModified: Date

    let item: Item 
    var images: [UIImage]
    var likes: Int

    init(item: Item, images: [UIImage], likes: Int = 0) {

        postUuid = UUID().uuidString
        userUuid = User.user.uid!

        datePosted = Date()
        dateModified = datePosted

        self.item = item
        self.images = images
        
        self.likes = likes
    }

}
