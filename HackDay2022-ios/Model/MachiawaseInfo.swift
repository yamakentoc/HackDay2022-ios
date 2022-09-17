//
//  MachiawaseInfo.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/17.
//

import Foundation

/// 待ち合わせに関する情報
struct MachiawaseInfo: Codable {
    let machiawase: Machiawase
}

/// 待ち合わせ
struct Machiawase: Codable {
    /// ID
    let id: Int
    /// 行き先
    let destination: String
    /// 待ち合わせ時間
    let machiawaseTime: String
    /// 待ち合わせユーザ
    let machiawaseUser: [MachiawaseUser]

    enum CodingKeys: String, CodingKey {
        case id, destination
        case machiawaseTime = "machiawase_time"
        case machiawaseUser = "machiawase_user"
    }
}

/// 待ち合わせユーザ
struct MachiawaseUser: Codable {
    /// ユーザ
    let user: User
    /// イベント
    let events: [Event]
    /// 予定よりも早い時間
    let expectedDiff: Int
    ///  家を出るまで
    let leaveAt: Int
    
    enum CodingKeys: String, CodingKey {
        case user, events
        case expectedDiff = "expected_diff"
        case leaveAt = "leave_at"
    }
}

/// イベント（タスク）
struct Event: Codable {
    /// 支度の内容
    let shitakuItem: ShitakuItem
    /// 作成した時間
    let createdAt: String?
    /// 残り時間
    let timeLeft: Int
    /// 完了したか
    let isFinished: Bool

    enum CodingKeys: String, CodingKey {
        case shitakuItem = "shitaku_item"
        case createdAt = "created_at"
        case timeLeft = "time_left"
        case isFinished = "is_finished"
    }
}

/// 支度の内容
struct ShitakuItem: Codable {
    /// やること
    let todo: String
    /// 所要時間
    let time: Int
}

/// ユーザ
struct User: Codable {
    /// ユーザ名前
    let name: String
    /// 住所
    let address: String
}
