//
//  Extension.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json as? [String: Any]
        } catch {
            print("对象转字典失败: \(error)")
            return nil
        }
    }
}

enum ArticleType {
    case HOME
    case SQUARE
    case WECHAT
    case PROJECT
}



