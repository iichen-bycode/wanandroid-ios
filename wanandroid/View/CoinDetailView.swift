//
//  CoinDetailView.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/20.
//

import SwiftUI

struct CoinDetailView: View {
    @StateObject var coinDetailViewModel = CoinDetailViewModel()
    @EnvironmentObject var loginViewModel:LoginViewModel
    
    var body: some View {
        Text("\(loginViewModel.coinInfo?.coinCount ?? 0)").fontWeight(.bold)
        List {
            ForEach(Array(coinDetailViewModel.coinList.enumerated()),id: \.element.userId) { index,rank in
                HStack {
                    VStack(alignment:.leading) {
                        Text(rank.reason ?? "")
                        Text(rank.desc ?? "").fontWeight(.bold)                    }
                    Spacer()
                    Text("+\(rank.coinCount ?? 0)")
                }.tag(index)
            }
            if !coinDetailViewModel.isOver {
                Text("加载中...").onAppear {
                    coinDetailViewModel.fetchRankInfo(isRefresh: false)
                }
            }
        }.listStyle(PlainListStyle()).onAppear {
            coinDetailViewModel.fetchRankInfo(isRefresh: true)
        }
    }
}

#Preview {
    CoinDetailView()
}
