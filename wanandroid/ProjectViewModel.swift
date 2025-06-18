//
//  ProjectViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/18.
//

import Foundation
class ProjectViewModel: ObservableObject {
    @Published var projectCategoryList = [CategoryModel]()
    
    func fetchProjectCategoryTab() {
        AFViewModel.shared.request(url: Constant.PROJECT_CATEGORY) { (result: Result<[CategoryModel]?,Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data {
                        self.projectCategoryList = data
                    }
                case .failure(let error):
                    print(">>>>>>>project category \(error)")
                }
            }
        }
    }
}
