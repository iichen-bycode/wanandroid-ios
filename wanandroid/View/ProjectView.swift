//
//  ProjectView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI

struct ProjectView: View {
    @StateObject var projectViewModel = ProjectViewModel()
    @State var selectedTab = 0
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(projectViewModel.projectCategoryList.indices, id: \.self) { index in
                            Button(action: {
                                withAnimation {
                                    selectedTab = index
                                }
                            }) {
                                Text(projectViewModel.projectCategoryList[index].name)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(selectedTab == index ? .blue : .gray)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(
                                        Capsule()
                                            .fill(selectedTab == index ? Color.blue.opacity(0.2) : Color.clear)
                                    )
                            }.id(projectViewModel.projectCategoryList[index].id)
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
                 ForEach(projectViewModel.projectCategoryList.indices, id: \.self) { index in
                     ArticleView(articleType: ArticleType.PROJECT,categoryId:projectViewModel.projectCategoryList[index].id)
                         .tag(index).onAppear {
                             
                         }
                 }
             }
             .tabViewStyle(.page(indexDisplayMode: .never))
        }.onAppear {
            projectViewModel.fetchProjectCategoryTab()
        }
    }
}

#Preview {
    ProjectView()
}
