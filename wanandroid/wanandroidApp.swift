//
//  wanandroidApp.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI

    @main
    struct wanandroidApp: App {
        @StateObject var loginViewModel = LoginViewModel()
        var body: some Scene {
            WindowGroup {
                ContentView().environmentObject(loginViewModel).onAppear {
                    AccountManager.shared.loadUser()
                    print(">>>>>  是否登录 \(AccountManager.shared.isLoggedIn)")
                    loginViewModel.isLoggingIn = AccountManager.shared.isLoggedIn
                }.toast()
            }
        }
    }
