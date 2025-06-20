//
//  CommonViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation

class ArticleViewModel: ObservableObject {
    @Published var error:Error?
    @Published var artcileList = [ArticleWrap.Article]()
    var isOver:Bool = false;
    private var page:Int = 0;
    
    private var categoryId:Int = 0
    private var articleType:ArticleType = ArticleType.HOME
    
    func fetchActicle(articleType: ArticleType,isRefresh: Bool = false,categoryId:Int = 0) {
        self.categoryId = categoryId
        self.articleType = articleType
        if(isRefresh) {
            page = 0
        }
        if(isOver && !isRefresh) {
            return
        }
        AFViewModel.shared.request(url: getUrl(articleType: articleType)) { (result: Result<ArticleWrap?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let articleWrap):
                    if let articleWrap = articleWrap {
                        self.isOver = articleWrap.over
                        self.page = self.page + 1
                        if isRefresh {
                            self.artcileList.removeAll()
                        }
                        self.artcileList.append(contentsOf: articleWrap.datas)
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func toggleCollect(article: ArticleWrap.Article) {
        let isNowCollected = !(article.collect ?? true)
        let url = isNowCollected
        ? "\(Constant.BASE_URL)/lg/collect/\(article.id)/json"
        : (articleType == ArticleType.COLLECT ? "\(Constant.BASE_URL)/lg/uncollect/\(article.id)/json" : "\(Constant.BASE_URL)/lg/uncollect_originId/\(article.id)/json")
        
        AFViewModel.shared.request(url: url,method: .post,parameters: articleType == ArticleType.COLLECT ? [
            "originId":article.originId ?? 0
        ] : nil) { (result: Result<String?,Error>) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    guard let index = self.artcileList.firstIndex(where: { $0.id == article.id }) else { return }
                    if self.articleType == ArticleType.COLLECT {
                        self.artcileList.remove(at: index)
                    } else {
                        self.artcileList[index].collect = isNowCollected
                    }
                }
            case .failure(let error):
                print("收藏失败：\(error)")
                return
            }
        }
    }
    
    func getUrl(articleType:ArticleType) -> String {
        switch articleType {
        case ArticleType.HOME:
            return "\(Constant.BASE_URL)/article/list/\(page)/json"
        case ArticleType.SQUARE:
            return "\(Constant.BASE_URL)/user_article/list/\(page)/json"
        case ArticleType.WECHAT:
            return "\(Constant.BASE_URL)/wxarticle/list/\(categoryId)/\(page)/json"
        case ArticleType.PROJECT:
            return "\(Constant.BASE_URL)/project/list/\(page)/json?cid=\(categoryId)"
        case ArticleType.COLLECT:
            return "\(Constant.BASE_URL)/lg/collect/list/\(page)/json"
        }
    }
}
