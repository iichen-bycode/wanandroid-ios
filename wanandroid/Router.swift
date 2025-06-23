//
//  Router.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/19.
//

import Foundation
import SwiftUI
class Router: ObservableObject {
    static let share = Router()
    private init(){}
    
    @Published var path:[Route] = []
    /// 推入新页面
     func push(_ route: Route) {
         DispatchQueue.main.async {
             self.path.append(route)
         }
     }

     /// 返回上一页
     func pop() {
         DispatchQueue.main.async {
             _ = self.path.popLast()
         }
     }

     /// 返回首页
     func popToRoot() {
         DispatchQueue.main.async {
             self.path.removeAll()
         }
     }
}

enum Route: Hashable {
    case LOGIN
    case RANK
    case COLLECT
    case COIN
    case SEARCH
    case SEARCH_RESULT(key:String)
}
