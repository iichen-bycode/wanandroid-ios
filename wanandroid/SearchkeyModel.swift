//
//  SearchkeyModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/20.
//

import Foundation
struct SearchkeyModel: Codable,Hashable {
    let id: Int
    let link, name: String
    let order, visible: Int
}
