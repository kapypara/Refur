import UIKit

// Post class should only be called when user is logged in
class Post {

    // owner
    let postUuid: String
    let userUuid: String

    var datePosted: Date
    var dateModified: Date

    let item: Item
    var images: [String]
    var likes: Int

    init(item: Item, images: [String], likes: Int = 0) {

        postUuid = UUID().uuidString
        userUuid = User.uid ?? "Guest"

        datePosted = Date()
        dateModified = datePosted

        self.item = item
        self.images = images
        
        self.likes = likes
    }
    

    private init(postUuid: String, userUuid: String, datePosted: Date, dateModified: Date, item: Item, images: [String], likes: Int) {
        self.postUuid = postUuid
        self.userUuid = userUuid
        self.datePosted = datePosted
        self.dateModified = dateModified
        self.item = item
        self.images = images
        self.likes = likes
    }
    
    static func loadPost(uuid: String, dictionary: [String: Any]) -> Post? {
        
        
        guard
            let itemDict = dictionary["Item"] as? [String: Any],
            let item = Item.loadItem(dictionary: itemDict),
              
            let dateModifiedDouble = dictionary["DateModified"] as? Double,
            let datePostedDouble = dictionary["DatePosted"] as? Double,
            
            let userUuid = dictionary["UserId"] as? String,
            let likes = dictionary["Likes"] as? Int,
                
            let images = dictionary["Images"] as? [String]
        else {
            print("[Post.loadPost] error parsing Poast, dumping dict", dictionary)
            return nil
        }
        
        let postUuid = uuid
        
        let dateModified = Date(timeIntervalSince1970: dateModifiedDouble)
        let datePosted = Date(timeIntervalSince1970: datePostedDouble)
        
        
        //print(datePosted, dateModified, images, likes, item, likes, postUuid, userUuid)
        
        return Post.init(postUuid: postUuid, userUuid: userUuid, datePosted: datePosted, dateModified: dateModified, item: item, images: images, likes: likes)
    }
    
    static func savePost(post: Post, postUuid: String = UUID().uuidString) -> String {
        
        let dateModified: Double = post.dateModified.timeIntervalSince1970
        let datePosted: Double = post.datePosted.timeIntervalSince1970
        
        var size: Any
        var type: Any
        
        if let clothingSize = post.item.size as? ClothingSize {
            size = clothingSize.rawValue
        } else if let doubleSize = post.item.size as? Double {
            size = doubleSize
        } else if let sizeUnwarpped = post.item.size {
            size = sizeUnwarpped
        } else {
            print("[Post.savePost] cant do size!")
            return postUuid
        }
        
        if let clothingType = post.item.type as? ClothingType {
            type = clothingType.rawValue
        } else if let bookType = post.item.type as? BookType {
            type = bookType.rawValue
        } else { //if let otherType = post.item.type as? OtherType {
            type = (post.item.type as? OtherType)?.rawValue ?? ClothingType.TShirt.rawValue
        }
        
        Database.Posts[postUuid].setValue([
            "DateModified": dateModified,
            "DatePosted": datePosted,
            "Images": post.images,
            "Likes": post.likes,
            "UserId": post.postUuid,
            "Item": [
                "Brand": post.item.brand ?? " ",
                "Category": post.item.category.rawValue,
                "Condition": post.item.condition.rawValue,
                "Description": post.item.description,
                "Name": post.item.name,
                "Price": post.item.price,
                "Size": size,
                "Type": type
            ]
        ])
        
        
        return postUuid
    }
    
}
