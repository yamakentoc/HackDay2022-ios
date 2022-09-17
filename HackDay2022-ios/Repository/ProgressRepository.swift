//
//  TaskRepository.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/14.
//

import Foundation

protocol ProgressRepository {
    /// 待ち合わせに関する情報を取得する
    /// - Returns: 待ち合わせに関する情報
    func getMachiawaseInfo() -> MachiawaseInfo
    
    /// 自分のタスク一覧を取得する
    /// - Returns: タスク一覧
    func getMyTaskList() -> [Task]
    
    /// 相手の進捗状況一覧を取得する
    /// - Returns: 相手の進捗状況一覧
    func getPartnerProgressList() -> [PartnerProgress]
}


final class DefaultProgressRepository: ProgressRepository {
    
    func getMachiawaseInfo() -> MachiawaseInfo {
        guard let url = Bundle.main.url(forResource: "mockMachiawaseInfo", withExtension: "json") else {
            fatalError("ファイルなし")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
        let decoder = JSONDecoder()
        
        guard let machiawaseInfo = try? decoder.decode(MachiawaseInfo.self, from: data) else {
            fatalError("JSONデコードエラー")
        }
        return machiawaseInfo
    }
    
    func getMyTaskList() -> [Task] {
        return [
            Task(name: "持っていくものまとめる", time: "5", progress: .notYet),
            Task(name: "ヘアセット", time: "5", progress: .notYet),
            Task(name: "服着る", time: "2", progress: .notYet),
            Task(name: "髪乾かす", time: "3", progress: .now),
            Task(name: "化粧水つける", time: "2", progress: .done),
            Task(name: "シャワー", time: "10", progress: .done),
            
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "hoge", time: "5", progress: .done),
            Task(name: "歯磨きする", time: "5", progress: .done),
            Task(name: "朝ご飯食べる", time: "15", progress: .done),
        ]
    }
    
    func getPartnerProgressList() -> [PartnerProgress] {
        return [
            PartnerProgress(name: "じーこ", moveMode: "徒歩", arrivalDate: "15:00", progressRate: 400),
            PartnerProgress(name: "しゅーぞー", moveMode: "徒歩", arrivalDate: "15:10", progressRate: 150),
            PartnerProgress(name: "やまけん", moveMode: "徒歩", arrivalDate: "15:05", progressRate: 300),
        ]
    }
        
}
