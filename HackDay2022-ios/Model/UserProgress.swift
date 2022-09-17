//
//  PartnerProgress.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/16.
//

import Foundation

/// 相手の進捗状況
struct PartnerProgress: Identifiable {
    var id = UUID()
    /// 名前
    var name: String
    /// 移動方法
    var moveMode: String
    /// 到着時間
    var arrivalDate: String
    /// 進捗率
    var progressRate: Double
}
