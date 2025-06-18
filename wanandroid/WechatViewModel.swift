//
//  WechatViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/18.
//

import Foundation
class WechatViewModel: ObservableObject {
    @Published var wechatAuthorsList = [CategoryModel]()
    
    func fetchWechatTab() {
        AFViewModel.shared.request(url: Constant.WECHAT_AUTHORS) { (result: Result<[CategoryModel]?,Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data {
                        self.wechatAuthorsList = data
                    }
                case .failure(let error):
                    print(">>>>>>>wechat authors \(error)")
                }
            }
        }
    }
}
