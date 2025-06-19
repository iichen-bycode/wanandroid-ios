//
//  ContentView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var afViewModel = AFViewModel.shared
    @State private var selectedTab = 0
    
    @State var menuWidth = UIScreen.main.bounds.width - 60
    @State var offsetX = -UIScreen.main.bounds.width + 60
    
    var body: some View {
        ZStack {
            NavigationStack() {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("首页")
                        }.tag(0)
                    SquareView()
                        .tabItem {
                            Image(systemName: "square.grid.2x2.fill")
                            Text("广场")
                        }.tag(1)
                    WeChatView()
                        .tabItem {
                            Image(systemName: "message.fill") // 公众号图标
                            Text("公众号")
                        }.tag(2)
                    ProjectView()
                        .tabItem {
                            Image(systemName: "hammer.fill") // 项目图标
                            Text("项目")
                        }.tag(3)
                }.navigationDestination(isPresented: $afViewModel.shouldShowLogin) {
                    LoginView()
                }.navigationBarTitle(buildBarTitle(),displayMode: .inline)
                .navigationBarItems(leading: Image(systemName: "list.bullet").onTapGesture {
                    withAnimation {
                        offsetX = 0
                    }
                })
                .navigationBarItems(trailing: (selectedTab == 1 ? Image(systemName: "plus") : Image(systemName: "magnifyingglass")).onTapGesture {
                    ToastManager.share.toast("搜索")
                })
            }
            SlideOutMenu(menuWidth: $menuWidth, offsetX: $offsetX)
        }
    }
    
    func buildBarTitle() -> String{
        switch selectedTab {
        case 0: return "首页"
        case 1: return "广场"
        case 2: return "公众号"
        case 3: return "项目"
        default: return ""
        }
    }
}

#Preview {
    ContentView().environmentObject(LoginViewModel())
}
