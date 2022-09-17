//
//  MyProgressViewModel.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/13.
//

import Foundation

/// 自分の準備画面のViewModel
final class MyProgressViewModel: ObservableObject {
    @Published var taskList: [Task]
    @Published var meetingInfo: MeetingInfo
    @Published var moveTime: String = ""
    
    @Published var machiawase: Machiawase
    
    private let progressRepository: ProgressRepository
    private let meetingInfoRepository: MeetingInfoRepository
    
    init(progressRepository: ProgressRepository = DefaultProgressRepository(),
         meetingInfoRepository: MeetingInfoRepository = DefaultMeetingInfoRepository()) {
        self.progressRepository = progressRepository
        self.meetingInfoRepository = meetingInfoRepository
        self.taskList = progressRepository.getMyTaskList()
        self.meetingInfo = meetingInfoRepository.getMeetingInfo()
        
        self.machiawase = progressRepository.getMachiawaseInfo().machiawase
    }
    
    /// タスク一覧を取得する
    func getTaskList() {
        taskList = progressRepository.getMyTaskList()
    }
    
    /// 集合情報を取得する
    func getMeetingInfo() {
        meetingInfo = meetingInfoRepository.getMeetingInfo()
    }
    
    /// セルの位置を取得する
    /// - Parameter index: セルのindex
    /// - Returns: セルの位置
    func getCellPosition(_ index: Int) -> CellPosition {
        switch index {
        case 0: return .top
        case taskList.count - 1: return .bottom
        default: return .center
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=%E5%9B%9B%E8%B0%B7%E9%A7%85&destination=%E6%B0%B8%E7%94%B0%E7%94%BA%E9%A7%85&key=AIzaSyDZJKzDSdQgtiiOS97ta4BWKaemRg-0uIE") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            let decoder = JSONDecoder()
            guard let moveInfoResponse = try? decoder.decode(MoveInfoResponse.self, from: data) else { return }
            DispatchQueue.main.async {
                self.moveTime = moveInfoResponse.getMoveTime()
            }
        }
        task.resume()
    }
    
    
    
    
}
