//
//  ArticleView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import SwiftUI

struct ArticleView: View {
    let articleType: ArticleType
    @StateObject var viewModel = ArticleViewModel()

    // 公众号数据使用
    var categoryId:Int = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(viewModel.artcileList,id: \.id) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            VStack(alignment: .leading) {
                                HStack(){
                                    Text(((article.shareUser?.isEmpty == false) ? article.shareUser! : article.author) ?? "")
                                    Spacer()
                                    Text(article.niceDate ?? "")
                                }.font(Font.subheadline).foregroundColor(.gray)
                                Text(article.title).lineLimit(2).truncationMode(.tail).padding(.bottom,10)
                                HStack() {
                                    Text("\(article.superChapterName ?? "") / \(article.chapterName ?? "")")
                                        .font(Font.subheadline).foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: (article.collect ?? true) ? "heart.fill" : "heart")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                        .foregroundColor((article.collect ?? true) ? .red : .gray)
                                                        .onTapGesture(perform: {
                                                            viewModel.toggleCollect(article: article)
                                                        })
                                    
                                }
                             }
                        }
                    }
                    if !viewModel.isOver {
                        Text("加载中...").onAppear {
                            viewModel.fetchActicle(articleType: self.articleType,categoryId: categoryId)
                        }
                    }
                }.refreshable {
                    print(">>>> refresh")
                    viewModel.fetchActicle(articleType: self.articleType,isRefresh: true,categoryId: categoryId)
                }.listStyle(PlainListStyle())
                if !viewModel.artcileList.isEmpty {
                    Button(action: {
                        withAnimation {
                            proxy.scrollTo(viewModel.artcileList[0].id,anchor: .top)
                        }
                    }) {
                        Image(systemName: "arrow.up.to.line")
                           .font(.system(size: 20))
                           .padding()
                           .background(Color.blue.opacity(0.8))
                           .foregroundColor(.white)
                           .clipShape(Circle())
                           .shadow(radius: 5)
                    }.padding()
                     .buttonStyle(PlainButtonStyle())
                }
            }
        }
        
    }
}

#Preview {
    ArticleView(articleType: ArticleType.SQUARE)
}
