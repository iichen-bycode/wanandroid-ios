//
//  ToastManager.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/19.
//

import Foundation
class ToastManager: ObservableObject {
    static let share = ToastManager()
    private init() {}
    
    @Published var message:String = ""
    @Published var isShowing:Bool = false
    
    // 单位是秒
    func toast(_ msg:String,duration:TimeInterval = 1.2) {
        self.message = msg
        self.isShowing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
            self.isShowing = false
        })
    }
}
