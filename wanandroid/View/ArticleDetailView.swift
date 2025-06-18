//
//  ArticleDetailView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/17.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: ArticleWrap.Article
    @State private var progress: Double = 0

    var body: some View {
        VStack(spacing: 0) {
            if progress < 1 {
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(height: 2)
                    .animation(.easeInOut, value: progress)
            }
            
            WebView(url: URL(string: article.link ?? "")!, progress: $progress)
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    ArticleDetailView(article: ArticleWrap.Article(ur))
//}
