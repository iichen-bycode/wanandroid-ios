//
//  RankWrap.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/19.
//

import Foundation
struct RankWrap: Codable {
   let curPage: Int
   let datas: [CoinInfo]
   let offset: Int
   let over: Bool
   let pageCount, size, total: Int
}
