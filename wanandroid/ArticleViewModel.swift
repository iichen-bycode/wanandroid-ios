//
//  CommonViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation

class CommonViewModel: ObservableObject {
    
    func doCollect(id: String) {
        AFViewModel.shared.request(url: "\(Constant.BASE_URL)/lg/collect/\(id)/json",method: .post) { (result: Result<String,Error>) in
            switch result {
            case .success(let r):
                print(">>>>>>  收藏结果 \(r)")
            case .failure(let error):
                return
            }
        }
    }
    
    func doUnCollect(id: String) {
        AFViewModel.shared.request(url: "\(Constant.BASE_URL)/lg/uncollect_originId/\(id)/json",method: .post) { (result: Result<String,Error>) in
            switch result {
            case .success(let r):
                print(">>>>>>  收藏结果 \(r)")
            case .failure(let error):
                return
            }
        }
    }
}
