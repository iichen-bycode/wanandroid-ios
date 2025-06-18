//
//  BaseResponse.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/13.
//

import Foundation

// Network/BaseResponse.swift
struct BaseResponse<T: Decodable>: Decodable {
    let errorCode: Int
    let data: T?
    let errorMsg:String = ""
}
