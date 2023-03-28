

// Post class should only be called when user is logged in
class Post {

    // owner
    let postUuid: String
    let userUuid: String

    var datePosted: Date
    var dateModified: Date

    let item: Item 
    var images: [Images]
    var likes: Int

    init(item: Item, images: [Images]) {

        // set the post and user uuid
        // postUuid = 
        // userUuid = 

        // set teh date
        // datePosted = 
        // dateModified = datePosted

        self.item = item
        self.images = images
    }

}
