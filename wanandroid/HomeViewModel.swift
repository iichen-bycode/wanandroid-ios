//
//  HomeViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI
import Alamofire

class HomeViewModel: ObservableObject {
    @Published var bannerList = [Banner]()
    
    func fetchBannel() {
        AF.request(Constant.BANNER)
            .validate()
            .responseDecodable(of: BaseResponse<[Banner]>.self) { response in
                switch response.result {
                case .success(let banner) :
                    self.bannerList = banner.data ?? []
                case .failure(let error):
                    return
                }
            }
    }
}


