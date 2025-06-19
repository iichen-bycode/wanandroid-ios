//
//  RankView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/18.
//

import SwiftUI

struct RankView: View {
    @StateObject var rankViewModel = RankViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(rankViewModel.rankList.enumerated()),id: \.element.userId) { index,rank in
                    HStack {
                        Text("\(index)  ")
                        Text(rank.username ?? "").fontWeight(.bold)
                        Spacer()
                        Text("\(rank.coinCount ?? 0)")
                    }.tag(index)
                }
                if !rankViewModel.isOver {
                    Text("加载中...").onAppear {
                        rankViewModel.fetchRankInfo(isRefresh: false)
                    }
                }
            }.navigationTitle("积分排行榜").listStyle(PlainListStyle())
        }.onAppear {
            rankViewModel.fetchRankInfo(isRefresh: true)
        }
    }
}

#Preview {
    RankView()
}
