//
//  LoginView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import SwiftUI

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repassword: String = ""
  
    @EnvironmentObject var loginViewModel:LoginViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            Form {
                Section(footer: HStack() {
                    Spacer()
                    Text(loginViewModel.isRegisterStatus ? "登录" : "注册").padding(.top,6).font(.system(size: 18)).foregroundColor(.blue).onTapGesture {
                        loginViewModel.isRegisterStatus = !loginViewModel.isRegisterStatus
                    }
                }) {
                    TextField("请输入账号", text: $username)
                        .disableAutocorrection(true)
                    
                    SecureField("请输入密码", text: $password)
                    
                    if loginViewModel.isRegisterStatus {
                        SecureField("请再次输入密码", text: $repassword)
                    }
                }
                
                
                
                Section {
                    Button(action: {
                        // 登录逻辑处理
                        print("用户名：\(username), 密码：\(password)")
                        if loginViewModel.isRegisterStatus {
                            loginViewModel.doRegister(registerReq: RegisterReq(username:username, password: password, repassword: repassword))
                        } else {
                            loginViewModel.doLogin(loginReq: LoginReq(username: username, password: password)) {
                                dismiss()
                            }
                        }
                    }) {
                        if loginViewModel.isLoggingIn {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        } else {
                            Text(loginViewModel.isRegisterStatus ? "注册" : "登录")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .disabled(username.isEmpty || password.isEmpty)
                }
            }
            .contentMargins(20)
            .navigationTitle(loginViewModel.isRegisterStatus ? "注册" : "登录")
        }).background(Color.red)
        
    }
}


#Preview {
    LoginView()
}
