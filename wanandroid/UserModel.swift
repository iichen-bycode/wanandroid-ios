//
//  LoginModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation
class LoginModel: Codable {
    let admin: Bool
    let coinCount: Int
    let collectIDS: [Int]
    let email, icon: String
    let id: Int
    let nickname, password, publicName, token: String
    let type: Int
    let username: String
}
