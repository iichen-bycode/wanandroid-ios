//
//  AFViewModel.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation
import Alamofire

class AFViewModel: ObservableObject {
    static let shared = AFViewModel()
    private init() {}

    /// 通用请求方法
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T?, Error>) -> Void
    ) {
        print(">>>>>>>>请求 url \(url)")
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: BaseResponse<T>.self) { response in
                switch response.result {
                case .success(let baseResponse):
                    if baseResponse.errorCode == -1001 {
                        DispatchQueue.main.async {
                            print(">>>>>>需要登录<<<<<<")
                            Router.share.push(.LOGIN)
                            if AccountManager.shared.isLoggedIn {
                                AccountManager.shared.logout()
                                print(">>>>>>登录失效<<<<<<")
                            }
                        }
                        return
                    }
                    
//                    if let data = baseResponse.data {
//                        completion(.success(data))
//                    } else {
//                        completion(.failure(NSError(domain: "", code: -9999, userInfo: [NSLocalizedDescriptionKey: baseResponse.errorMsg])))
//                    }
                    completion(.success(baseResponse.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
