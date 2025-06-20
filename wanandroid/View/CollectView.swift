//
//  CollectView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/20.
//

import SwiftUI

struct CollectView: View {
    var body: some View {
        VStack {
            ArticleView(articleType: ArticleType.COLLECT)
        }
    }
}

#Preview {
    CollectView()
}
