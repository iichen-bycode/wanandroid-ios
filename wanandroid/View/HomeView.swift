//
//  HomeView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI
import NukeUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var currentIndex = 0

    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        
    
    var body: some View {
        NavigationView {
            VStack {
                // banner
                TabView(selection: $currentIndex) {
                    ForEach(Array(viewModel.bannerList.enumerated()), id: \.element.id) { index, banner in
                        LazyImage(url: URL(string: banner.imagePath)) { phase in
                            phase.image?
                                .resizable()
                                .scaledToFill()
                        }
                        .tag(index)
                    }
                }
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .onReceive(timer) { _ in
                    guard !viewModel.bannerList.isEmpty else { return }
                    
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut) {
                            currentIndex = (currentIndex + 1) % viewModel.bannerList.count
                        }
                    }
                }
                // 文章
                ArticleView(articleType: ArticleType.HOME)
            }
        }
        .onAppear {
            viewModel.fetchBannel()
        }
    }
}

#Preview {
    HomeView()
}
