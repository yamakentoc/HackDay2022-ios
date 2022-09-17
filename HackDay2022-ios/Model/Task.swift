//
//  Task.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/14.
//

import Foundation

/// タスク
struct Task: Identifiable {
    // セル表示用の識別子
    var id = UUID()
    // タスク名
    var name: String = ""
    // タスクの時間
    var time: String = ""
    // タスクの進捗
    var progress: Progress

    // 進捗
    enum Progress {
        // まだしてない
        case notYet
        // 進行中
        case now
        // 完了
        case done

        /// 進捗とセルの位置に合わせた画像名を取得
        /// - Parameter cellPosition: セルの位置
        /// - Returns: 進捗とセルの位置に合わせた画像名
        func getImageString(_ cellPosition: CellPosition) -> String {
            switch self {
            case .notYet, .done:
                return "my_progress_\(cellPosition.rawValue)"
            case .now:
                return "my_progress_\(cellPosition.rawValue)_now"
            }
        }
    }
}
