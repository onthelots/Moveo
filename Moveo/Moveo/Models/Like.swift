//
//  Likes.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/19.
//

import Foundation

struct Like: Codable, Identifiable {
    // MARK: 좋아요를 누른 유저의 uid, nickName, profileImage 값으로 사용
    var id: String
    var nickName: String
    var profileImage: String
}
