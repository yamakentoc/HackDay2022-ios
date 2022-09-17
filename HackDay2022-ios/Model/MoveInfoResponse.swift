//
//  MoveTImeModel.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/13.
//

import Foundation

/// 移動時間に関するレスポンス
struct MoveInfoResponse: Codable {
    var routes: [Routes]

    struct Routes: Codable {
        var legs: [Legs]
    }

    struct Legs: Codable {
        var distance: Distance
        var duration: Duration
    }

    // 距離
    struct Distance: Codable {
        var text: String
    }

    // 移動時間
    struct Duration: Codable {
        var text: String
    }
    
    // 移動時間を取得する
    func getMoveTime() -> String {
        guard let route = routes.first,
              let leg = route.legs.first else { return "" }
        return leg.duration.text
    }

}

