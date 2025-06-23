//
//  SearchView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/20.
//

import SwiftUI
import Flow

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel()
    @State var searchText = ""
    
    var body: some View {
            VStack(alignment:.leading) {
                Text("热门搜索").font(.title3)
                HStack {
                    HFlow(rowSpacing: 14) {
                        ForEach(searchViewModel.hotSearchKeyList,id: \.id) { word in
                            Text(word.name)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .onTapGesture {
                                    Router.share.push(.SEARCH_RESULT(key: word.name))
                                }
                        }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.vertical).navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // 中间显示内容
                    ToolbarItem(placement: .principal) {
                        TextField("搜索", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.horizontal, 8)
                            .frame(height: 36)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    // 右上角按钮
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if self.searchText.isEmpty {
                                ToastManager.share.toast("请输入搜索关键词～")
                            } else {
                                Router.share.push(.SEARCH_RESULT(key: self.searchText))
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }.navigationBarTitle("搜索")
                .onAppear {
                    searchViewModel.getHotSearchKeys()
                }
    }
}

#Preview {
    SearchView()
}
