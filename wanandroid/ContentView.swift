//
//  ContentView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首页")
                }
            SquareView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("广场")
                }
            WeChatView()
                .tabItem {
                    Image(systemName: "message.fill") // 公众号图标
                    Text("公众号")
                }
            SystemView()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill") // 体系图标
                    Text("体系")
                }
            ProjectView()
                .tabItem {
                    Image(systemName: "hammer.fill") // 项目图标
                    Text("项目")
                }
        }
    }
}

#Preview {
    ContentView()
}
