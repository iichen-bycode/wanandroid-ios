//
//  WeChatView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI

struct WeChatView: View {
    @StateObject var wechatViewModel = WechatViewModel()
    @State var selectedTab = 0
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(wechatViewModel.wechatAuthorsList.indices, id: \.self) { index in
                            Button(action: {
                                withAnimation {
                                    selectedTab = index
                                }
                            }) {
                                Text(wechatViewModel.wechatAuthorsList[index].name)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(selectedTab == index ? .blue : .gray)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(
                                        Capsule()
                                            .fill(selectedTab == index ? Color.blue.opacity(0.2) : Color.clear)
                                    )
                            }.id(wechatViewModel.wechatAuthorsList[index].id)
                        }
                    }
                }.onChange(of: selectedTab) { newValue in
                    // 滑动内容时自动滚动 tab
                    withAnimation {
                        scrollProxy.scrollTo(newValue, anchor: .center)
                    }
                }.padding(.horizontal)
            }
//            Divider()
            TabView(selection: $selectedTab) {
                 ForEach(wechatViewModel.wechatAuthorsList.indices, id: \.self) { index in
                     ArticleView(articleType: ArticleType.WECHAT,categoryId:wechatViewModel.wechatAuthorsList[index].id)
                         .tag(index).onAppear {
                             
                         }
                 }
             }
             .tabViewStyle(.page(indexDisplayMode: .never))
        }.onAppear {
            wechatViewModel.fetchWechatTab()
        }
    }
}

#Preview {
    WeChatView()
}
