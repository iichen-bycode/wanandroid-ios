//
//  CoinDetailViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/20.
//

import Foundation
class CoinDetailViewModel: ObservableObject {
    // lg/coin/list/1/json
    @Published var coinList = [CoinInfo]()
    var isOver:Bool = false;
    private var page:Int = 1;
    
    func fetchRankInfo(isRefresh: Bool = false) {
        if(isRefresh) {
            page = 1
        }
        if(isOver && !isRefresh) {
            return
        }
        AFViewModel.shared.request(url: "\(Constant.BASE_URL)/lg/coin/list/\(page)/json") { (result: Result<RankWrap?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let rankWrap):
                    if let rankWrap = rankWrap {
                        self.isOver = rankWrap.over
                        self.page = self.page + 1
                        if isRefresh {
                            self.coinList.removeAll()
                        }
                        self.coinList.append(contentsOf: rankWrap.datas)
                    }
                case .failure(let error):
                    print(">>>> 获取积分明细error \(error)")
                }
            }
        }
    }
}
