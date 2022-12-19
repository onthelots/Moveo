//
//  Post.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/19.
//

import Foundation

struct Post: Codable, Identifiable {
    // MARK: UUID 값
    var id: String
    var bodyText: String
    var postImageUrl: String
    var postDate: String
    var postCategory: String
    
    // MARK: 글 작성자의 uid, profileImage, nickName 값
    var writerUid: String
    var profileImage: String
    var nickName: String
}
