//
//  RegisterReq.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/16.
//

import Foundation
struct RegisterReq : Encodable{
    let username:String
    let password:String
    let repassword:String
}
