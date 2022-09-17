//
//  CustomModifier.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/17.
//

import SwiftUI

extension View {
    func setNavigationBackButton() -> some View {
        self.modifier(SetNavigationBackButton())
    }
    
    func setScheduleTextFieldStyle(placeholder: String, inputText: String) -> some View {
        self.modifier(SetScheduleTextFieldStyle(placeholder: placeholder, inputText: inputText))
    }
    
    // TextFieldにplaceHolderを追加する
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

/// NavigationViewに戻るボタンをセットするmodifire
struct SetNavigationBackButton: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("back")
                    })
                }
            }
    }
}

/// 待ち合わせ予定作成画面用のTextFieldのスタイルを適用する
struct SetScheduleTextFieldStyle: ViewModifier {
    var placeholder: String
    var inputText: String
    
    func body(content: Content) -> some View {
        content
            .placeholder(when: inputText.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.textPrimaryLightColor)
                    .opacity(0.5)
            }
            .padding(6)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.textPrimaryLightColor, lineWidth: 2)
            }
    }
}
