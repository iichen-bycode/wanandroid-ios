//
//  SlideOutMenu.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/17.
//

import SwiftUI
struct SlideOutMenu: View {
    @Binding var menuWidth: CGFloat
    @Binding var offsetX: CGFloat
    
    @EnvironmentObject var loginViewModel:LoginViewModel
    
    @State var isShowLogoutAlert = false

    var body: some View {
        Form {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "trophy").onTapGesture {
                        withAnimation {
                            offsetX = -menuWidth
                        }
                        Router.share.push(.RANK)
                    }
                }
                VStack {
                    Text(AccountManager.shared.currentUser?.nickname ?? "未登录").fontWeight(.bold).padding(.bottom,6)
                    Text("等级:\(loginViewModel.coinInfo?.level ?? 0)     排名:\(loginViewModel.coinInfo?.rank ?? "--")")
                }.padding(.top,20)
            }.padding()
            
            Section {
                HStack {
                    Image(systemName: "medal")
                    Text("我的积分")
                    Spacer()
                    Text("\(loginViewModel.coinInfo?.coinCount ?? 0)")
                    Image(systemName: "chevron.right")
                }.contentShape(Rectangle()).onTapGesture {
                    withAnimation {
                        offsetX = -menuWidth
                    }
                    if !AccountManager.shared.isLoggedIn {
                        ToastManager.share.toast("请先登录～")
                        Router.share.push(.LOGIN)
                    } else {
                        Router.share.push(.COIN)
                    }
                }
                HStack {
                    Image(systemName: "heart")
                    Text("我的收藏")
                    Spacer()
                    Image(systemName: "chevron.right")
                }.contentShape(Rectangle()).onTapGesture {
                    withAnimation {
                        offsetX = -menuWidth
                    }
                    if !AccountManager.shared.isLoggedIn {
                        ToastManager.share.toast("请先登录～")
                        Router.share.push(.LOGIN)
                    } else {
                        Router.share.push(.COLLECT)
                    }
                }
                if loginViewModel.isLoggingIn {
                    HStack {
                        Image(systemName: "door.right.hand.open")
                        Text("退出登录")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.contentShape(Rectangle()).onTapGesture {
                        isShowLogoutAlert = true
                    }
                }
            }.padding()
        }
        .padding(.trailing, UIScreen.main.bounds.width - menuWidth)
        .padding(.top,50)
        .edgesIgnoringSafeArea(.all)
        .shadow(color: Color.black.opacity(offsetX != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
        .offset(x: offsetX)
        .onReceive(loginViewModel.$isLoggingIn) { isLogin in
            print(">>>>>>. 登录状态变化 \(isLogin)")
            if(isLogin) {
                loginViewModel.fetchUserInfo()
            }
        }
        .alert(isPresented: $isShowLogoutAlert) {
            Alert(title: Text("提示"),message: Text("确定注销吗？"),primaryButton:.destructive(Text("确定"), action: {
                loginViewModel.doLoginOut()
            }),secondaryButton:.cancel(Text("取消")) {
                isShowLogoutAlert = false
            })
        }
        .background(
            Color.black.opacity(offsetX == 0 ? 0.5 : 0)
                .ignoresSafeArea(.all, edges: .vertical)
                .onTapGesture {
                    withAnimation {
                        offsetX = -menuWidth
                    }
                })
    }
}
