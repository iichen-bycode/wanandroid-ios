//
//  HomeViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import SwiftUI
import Alamofire

class HomeViewModel: ObservableObject {
    @Published var error:AFError?
    @Published var artcileList = [ArticleWrap.Article]()
    @Published var bannerList = [Banner]()
    var isOver:Bool = false;
    private var page:Int = 1;
    
    func fetchHomeActicle() {
        if(isOver) {
            return
        }
        AF.request("\(Constant.BASE_URL)/article/list/\(page)/json",method: .get)
            .validate()
            .responseDecodable(of: BaseResponse<ArticleWrap>.self) { response in
                switch response.result {
                case .success(let articleWrap) :
                    print(">>>> 首页文章 \(articleWrap.errorCode)")
                    self.isOver = articleWrap.data?.over ?? false
                    self.page = self.page + 1
//                    if(articleWrap.errorCode == -1001) {
//                        
//                    }
                    self.artcileList.append(contentsOf: articleWrap.data?.datas ?? [ArticleWrap.Article]())
                case .failure(let error):
                    print(">>>> 首页文章error \(error)")
                    self.error = error
                }
            }
    }
    
    func fetchBannel() {
        AF.request(Constant.BANNER)
            .validate()
            .responseDecodable(of: BaseResponse<[Banner]>.self) { response in
                switch response.result {
                case .success(let banner) :
                    print(">>>> banner \(banner.data)")
                    self.bannerList = banner.data ?? []
                case .failure(let error):
                    print(">>>> banner error \(error)")
                }
            }
    }
}


