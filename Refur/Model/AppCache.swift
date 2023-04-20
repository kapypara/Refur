//
//  AppCache.swift
//  Refur
//
//  Created by iOSdev on 15/04/2023.
//

import Foundation

class AppCache {
 
    private static var posts = NSCache<NSString, Post>()
    private static var profileDict = NSCache<NSString, Profile>()

    static func cachePost(post: Post, postOnly: Bool = false) {
        posts.setObject(post, forKey: post.postUuid as NSString)
        
        guard postOnly == false else { return }
        
        // if we find a new user that is not in the dict we added to it
        guard profileDict.object(forKey: post.userUuid as NSString) == nil else { return }
        Database.Users.getUser(user: post.userUuid) { loadedProfile in
            if let profile = loadedProfile {
                profileDict.setObject(profile, forKey: post.userUuid as NSString)
            }
        }
    }
    
    static func cacheProfile(profile: Profile, uuid: String) {
        profileDict.setObject(profile, forKey: uuid as NSString)
    }
    
    static func getPost(postUuid: String) -> Post? {
        return posts.object(forKey: postUuid as NSString)
    }
    
    static func getProfile(profileUuid: String) -> Profile? {
        return profileDict.object(forKey: profileUuid as NSString)
    }
    
    static func allItems() -> [Post] {
        guard
            let all = posts.value(forKey: "allObjects") as? NSArray as? [Post]
        else {
            return []
        }
        
        return all
    }
}
