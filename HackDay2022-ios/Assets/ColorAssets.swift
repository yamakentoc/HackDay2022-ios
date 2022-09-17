//
//  ColorAssets.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/14.
//

import Foundation
import SwiftUI

/// ColorAssetsに設定した色をColorとして呼び出し可能にする
extension Color {
    // ComponentのPrimary色
    static let componentPrimaryColor = Color("component_primary_color")
    // ComponentのSecondary色
    static let componentSecondaryColor = Color("component_secondary_color")
    // ComponentのTertiary色
    static let componentTertiaryColor = Color("component_tertiary_color")
    // Textのメインでライトな色
    static let textPrimaryLightColor = Color("text_primary_light_color")
    // TextのEarly色
    static let textEarlyColor = Color("text_early_color")
    // Listの背景色
    static let backgroundListColor = Color("background_list_color")
    // 基本となる背景色
    static let backgroundBaseColor = Color("background_base_color")
    // ComponentのSeekbarの色
    static let componentSeekbarColor = Color("component_seekbar_color")
}
