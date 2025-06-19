//
//  ToastViewModifier.swift
//  wanandroid
//
//  Created by gaimi on 2025/6/19.
//

import Foundation
import SwiftUI
struct ToastViewModifier: ViewModifier {
    @StateObject var toastManager = ToastManager.share
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if toastManager.isShowing {
                VStack {
                    Spacer()
                    Text(toastManager.message)
                        .font(.system(size: 14))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 50)
                        .transition(.opacity) // 进出动画
                        .opacity(toastManager.isShowing ? 1 : 0) // 动画渐变
                }
                .animation(.easeInOut(duration: 0.3), value: toastManager.isShowing)
            }
            
        }
    }
}
