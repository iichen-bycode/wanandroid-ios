//
//  RankViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/19.
//

import Foundation
class RankViewModel: ObservableObject {
    @Published var rankList = [CoinInfo]()
    var isOver:Bool = false;
    private var page:Int = 1;
    
    func fetchRankInfo(isRefresh: Bool = false) {
        if(isRefresh) {
            page = 1
        }
        if(isOver && !isRefresh) {
            return
        }
        AFViewModel.shared.request(url: "\(Constant.BASE_URL)/coin/rank/\(page)/json") { (result: Result<RankWrap?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let rankWrap):
                    if let rankWrap = rankWrap {
                        self.isOver = rankWrap.over
                        self.page = self.page + 1
                        if isRefresh {
                            self.rankList.removeAll()
                        }
                        self.rankList.append(contentsOf: rankWrap.datas)
                    }
                case .failure(let error):
                    print(">>>> 获取排行榜信息error \(error)")
                }
            }
        }
    }
}
