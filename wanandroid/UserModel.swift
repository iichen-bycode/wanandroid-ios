//
//  LoginModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation
class UserModel: Codable {
    let admin: Bool
    let coinCount: Int = 0
    let collectIDS: [Int]?
    let email, icon: String
    let id: Int
    let nickname, password, publicName, token: String
    let type: Int
    let username: String
}


struct UerInfoWrap: Codable {
    let coinInfo: CoinInfo
    let userInfo: UserModel
}

struct CoinInfo: Codable {
    let coinCount, level: Int?
    let nickname, rank: String?
    let userID: Int?
    let userId: Int?
    let username: String?
    let desc: String?
    let reason: String?
}
