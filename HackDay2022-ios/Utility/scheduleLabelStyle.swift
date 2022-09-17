//
//  scheduleLabelStyle.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/17.
//

import SwiftUI

/// 予定で使用するLabelStyle
struct ScheduleLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
        .foregroundColor(Color.textPrimaryLightColor)
        .bold()
    }
}


