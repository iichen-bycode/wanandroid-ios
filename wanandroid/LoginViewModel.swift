//
//  LoginViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation
class LoginViewModel: ObservableObject {
    
    func doLogin(loginReq: LoginReq) {
        AFViewModel.shared.request(url: Constant.LOGIN) { (result: Result<String,Error>) in
            
        
            
        }
    }
    
    func doLoginOut() {
        
    }
}
