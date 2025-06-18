//
//  LoginViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published var isLoggingIn:Bool = false
    @Published var isRegisterStatus: Bool = false
    @Published var isReuestStatus: Bool = false

    @Published var coinInfo:CoinInfo? = nil
    
    func doLogin(loginReq: LoginReq,completion: @escaping () -> Void) {
        isReuestStatus = true
        AFViewModel.shared.request(url: Constant.LOGIN,method:.post,parameters: loginReq.toDictionary() ) { (result: Result<UserModel?,Error>) in
            DispatchQueue.main.async {
                self.isReuestStatus = false
                switch result {
                case .success(let user):
                    completion()
                    print(">>>> 登录成功")
                    self.isLoggingIn = true
                    if let user = user {
                        AccountManager.shared.saveUser(user)
                    }
                case .failure(let error):
                    print(">>>>>>>loginViewModel \(error)")
                }
            }
        }
    }
    
    func doRegister(registerReq: RegisterReq) {
        isReuestStatus = true
        AFViewModel.shared.request(url: Constant.REGISTER,method:.post,parameters: registerReq.toDictionary() ) { (result: Result<UserModel?,Error>) in         
            DispatchQueue.main.async {
                self.isReuestStatus = false
                switch result {
                case .success(_):
                    print(">>>> 注册成功")
                    self.isRegisterStatus = false
                case .failure(let error):
                    print(">>>>>>>loginViewModel \(error)")
                }
            }
        }
    }
    
    func doLoginOut() {
        AFViewModel.shared.request(url: Constant.LOGINOUT) { (result: Result<String?,Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print(">>>> 注销成功")
                    self.isLoggingIn = false
                    self.coinInfo = nil
                    AccountManager.shared.logout()
                case .failure(let error):
                    print(">>>>>>>loginViewModel logout \(error)")
                }
            }
        }
    }
    
    func fetchUserInfo() {
        AFViewModel.shared.request(url: Constant.USERINFO) { (result: Result<UerInfoWrap?,Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data {
                        self.coinInfo = data.coinInfo
                    }
                case .failure(let error):
                    print(">>>>>>>getUserInfo \(error)")
                }
            }
        }
    }
}
