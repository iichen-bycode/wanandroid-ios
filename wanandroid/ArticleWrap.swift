//
//  Article.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import Foundation

struct ArticleWrap: Codable {

   let curPage: Int
   let datas: [Article]
   let offset: Int
   let over: Bool
   let pageCount, size, total: Int
    
    struct Tag:Codable {
        let name: String?
        let url: String?
    }
    

    struct Article: Codable,Identifiable {
        let adminAdd: Bool
        let apkLink: String?
        let audit: Int?
        let author: String?
        let canEdit: Bool
        let chapterID: Int?
        let chapterName: String?
        var collect: Bool
        let courseID: Int?
        let desc, descMd, envelopePic: String?
        let fresh: Bool
        let host: String?
        let id: Int
        let isAdminAdd: Bool
        let link: String?
        let niceDate, niceShareDate, origin, dataPrefix: String?
        let projectLink: String?
        let publishTime, realSuperChapterID, selfVisible, shareDate: Int?
        let shareUser: String?
        let superChapterID: Int?
        let superChapterName: String?
        let tags: [Tag]?
        let title: String
        let type, userID, visible, zan: Int?
    }
}
