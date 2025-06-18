//
//  AccountManager.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/17.
//

import Foundation
class AccountManager {
    static let shared = AccountManager()
    private init() {}

    private let userKey = "userInfo"

    private(set) var currentUser: UserModel?

    func saveUser(_ user: UserModel) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
            currentUser = user
        }
    }

    func loadUser() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(UserModel.self, from: data) {
            currentUser = user
        }
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: userKey)
        currentUser = nil
    }

    var isLoggedIn: Bool {
        return currentUser != nil
    }
}
