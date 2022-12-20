//
//  User.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/19.
//

import Foundation

struct User : Codable, Identifiable {
    var id : String
    var email : String
    var name : String
    var nickName : String
    var profileImageUrl : String
    var category : [String]
    var bookmark : [String]
    var description : String
}

struct Bookmark : Codable, Identifiable {
    var id : String
    var postUid : String
}

struct Follower : Codable, Identifiable {
    var id : String
    var followerUid : String
    var nickName : String
    var imageUrl : String
}

struct Following : Codable, Identifiable {
    var id : String
    var followingUid : String
    var nickName : String
    var imageUrl : String
}
