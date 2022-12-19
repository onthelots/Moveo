//
//  User.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/19.
//

import Foundation

struct User : Codable, Identifiable {
    var id : String
    var uid : String
    var email : String
    var name : String
    var nickName : String
}
