//
//  SearchResultView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/20.
//

import SwiftUI

struct SearchResultView: View {
    var key:String = ""
    
    var body: some View {
       ArticleView(articleType: ArticleType.SEARCH,searchKey: key)
        .navigationBarTitle(key)
    }
}

#Preview {
    SearchResultView(key: "自定义View")
}
