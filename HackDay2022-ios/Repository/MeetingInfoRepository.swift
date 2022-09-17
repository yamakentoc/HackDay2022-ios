//
//  MeetingInfo.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/16.
//

import Foundation

protocol MeetingInfoRepository {
    /// 集合情報を取得する
    /// - Returns: 集合情報
    func getMeetingInfo() -> MeetingInfo
    
}

final class DefaultMeetingInfoRepository: MeetingInfoRepository {
    func getMeetingInfo() -> MeetingInfo {
        return MeetingInfo(time: "10:00",
                           point: "渋谷駅",
                           transportation: "車で40分",
                           member: "やまけん じーこ",
                           prepareMySet: "メイクテキトーの日")
    }
}
