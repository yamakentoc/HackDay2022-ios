//
//  MachiawaseGetResponse.swift
//  HackDay2022-ios
//
//  Created by Daiki Kojima on 2022/09/17.
//

import Foundation

/// 待ち合わせに関する情報
struct MachiawaseInfo: Codable {
    let machiawase: Machiawase
}

/// 待ち合わせ
struct Machiawase: Codable {
    /// ID
    let appointmentActiveFlag: Bool
    /// 行き先
    let appointmentAddress: String
    /// 待ち合わせ時間
    let appointmentDatetime: String
    /// 待ち合わせユーザ
    let machiawaseUser: [MachiawaseUser]

    enum CodingKeys: String, CodingKey {
        case appointmentActiveFlag = "appointment_active_flag"
        case appointmentAddress = "appointment_address"
        case appointmentDatetime = "appointment_datetime"
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
    /// 残り時間
    let timeLeft: Int
    /// 完了したか
    let isFinished: Bool
    /// 進捗
    let progress: String

    enum CodingKeys: String, CodingKey {
        case progress
        case shitakuItem = "shitaku_item"
        case timeLeft = "time_left"
        case isFinished = "is_finished"
    }
}

/// 支度の内容
struct ShitakuItem: Codable {
    let beaconId: Int //ハードのボタンのID
    let shitakuItemId: Int // 支度アイテムのID
    let shitakuItemName: String // 支度アイテムの名前
    let shitakuItemTime: Int // 支度にかかる時間
    enum CodingKeys: String, CodingKey {
        case beaconId = "beacon_id"
        case shitakuItemId = "shitaku_item_id"
        case shitakuItemName = "shitaku_item_name"
        case shitakuItemTime = "shitaku_item_time"
    }
}

/// ユーザ
struct User: Codable {
    /// ユーザ名前
    let userName: String
    /// 住所
    let userAddress: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case userAddress = "user_address"
    }
}
