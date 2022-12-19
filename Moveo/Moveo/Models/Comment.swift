//
//  Comment.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/19.
//

import Foundation

struct Comment: Codable, Identifiable {
    // MARK: UUID값으로 만들어 줘야됨 (한개의 post에 같은 유저가 여러개의 댓글을 달 수 있기 때문에)
    var id: String
    
    // MARK: 댓글 단 사람의 uid, nickName, profileImage 값을 넣어줘야 함
    var uid: String
    var nickName: String
    var profileImage: String
    
    var commentText: String
    var commentDate: String
}
