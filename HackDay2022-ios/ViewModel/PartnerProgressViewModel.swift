//
//  PartnerProgressView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/16.
//

import Foundation

/// みんなの様子画面のViewModel
final class PartnerProgressViewModel: ObservableObject {
    /// 集合に関する情報
    @Published var meetingInfo: MeetingInfo
    /// 相手の進捗状況一覧
    @Published var partnerProgessList: [PartnerProgress]
    /// 選択された相手の進捗状況
    @Published var selectedPartnerProgress: PartnerProgress
    /// 集合に関する情報のRepository
    private let meetingInfoRepository: MeetingInfoRepository
    /// 進捗に関するRepository
    private let progressRepository: ProgressRepository
    
    init(meetingInfoRepository: MeetingInfoRepository = DefaultMeetingInfoRepository(),
         progressRepository: ProgressRepository = DefaultProgressRepository()) {
        self.meetingInfoRepository = meetingInfoRepository
        self.meetingInfo = meetingInfoRepository.getMeetingInfo()
        self.progressRepository = progressRepository
        self.partnerProgessList = progressRepository.getPartnerProgressList()
        self.selectedPartnerProgress = progressRepository.getPartnerProgressList().first!
    }
        
    /// 選択された相手の進捗状況を表示する
    /// - Parameter progress: 相手の進捗状況
    func showSelectedPartnerProgressData(progress: PartnerProgress) {
        selectedPartnerProgress = progress
    }
    
    /// 対象のpartnerProgressが選択状態かを返す
    /// - Parameter progress: 対象のpartnerProgress
    /// - Returns: 選択状態か
    func isSelectedPartnerProgress(_ progress: PartnerProgress) -> Bool {
        return progress.name == selectedPartnerProgress.name
    }
    
    
}
