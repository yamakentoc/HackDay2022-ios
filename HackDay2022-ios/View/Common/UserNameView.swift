//
//  UserNameView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/17.
//

import SwiftUI

/// ユーザ名を表示するView
struct UserNameView: View {
    /// ユーザ名
    var name: String
    /// 選択されているか
    var isSelected: Bool
    
    var body: some View {
        if isSelected {
            Text(name)
                .foregroundColor(.white)
                .bold()
                .fixedSize()
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.componentSecondaryColor)
                }
        } else {
            Text(name)
                .foregroundColor(.componentSecondaryColor)
                .bold()
                .fixedSize()
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.componentSecondaryColor, lineWidth: 2)
                        .background(Color.backgroundBaseColor)
                }
        }
    }
}

struct UserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameView(name: "ユーザ名", isSelected: true)
    }
}
