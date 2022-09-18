//
//  Task.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/14.
//

import Foundation

/// イベント
struct EventInfo: Identifiable {
    /// セル表示用の識別子
    var id = UUID()
    /// イベント名
    var name: String = ""
    /// 所要時間
    var time: Int
    /// 残り時間
    var timeLeft: Int
    /// タスクの進捗
    var progress: Progress

    /// 進捗
    enum Progress: String {
        // まだしてない
        case not_yet = "not_yet"
        // 進行中
        case doing = "doing"
        // 完了
        case done = "done"

        /// 進捗とセルの位置に合わせた画像名を取得
        /// - Parameter cellPosition: セルの位置
        /// - Returns: 進捗とセルの位置に合わせた画像名
        func getImageString(_ cellPosition: CellPosition) -> String {
            switch self {
            case .not_yet, .done:
                
                return "my_progress_\(cellPosition.rawValue)"
            case .doing:
                return "my_progress_\(cellPosition.rawValue)_doing"
            }
        }
    }
}
