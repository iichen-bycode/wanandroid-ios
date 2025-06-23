//
//  SearchViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/20.
//

import Foundation
class SearchViewModel: ObservableObject {
    @Published var hotSearchKeyList:[SearchkeyModel] = []

    func getHotSearchKeys() {
        AFViewModel.shared.request(url: "\(Constant.SEARCH_HOT_KEY)") { (result: Result<[SearchkeyModel]?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let serchkeys):
                    if let serchkeys = serchkeys {
                        self.hotSearchKeyList = serchkeys
                    }
                case .failure(let error):
                    print(">>>> 获取搜索热词error \(error)")
                }
            }
        }
    }
}
