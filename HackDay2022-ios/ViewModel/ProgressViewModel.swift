//
//  ProgressViewModel.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/13.
//

import Foundation

/// 進捗状況のViewModel
final class ProgressViewModel: ObservableObject {
    @Published var eventInfoList: [EventInfo] = []
    /// 集合に関する情報
    @Published var moveTime: String = ""
    @Published var machiawaseInfo: MachiawaseInfo?
    
    @Published var machiawaseUserMe: MachiawaseUser?

    @Published var selectedPartnerProgress: PartnerProgress = PartnerProgress(name: "", moveMode: "徒歩", arrivalDate: "", progressRate: 0)
    @Published var partnerProgressList: [PartnerProgress] = []
    
    
    init() {
        self.machiawaseInfo = nil
        self.fetchMachiawase()
        Timer
            .scheduledTimer(
                withTimeInterval: 30.0,
                repeats: true
            ) { _ in
                self.fetchMachiawase()
            }
    }
    
    /// 待ち合わせに関する情報をフェッチする
    func fetchMachiawase() {
        guard let url = URL(string: "https://orange-gembaneko.de.r.appspot.com/AppointmentUserStatus") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            let decoder = JSONDecoder()
            guard let machiawaseInfoResponse = try? decoder.decode(MachiawaseInfo.self, from: data) else {
                print("デバッグ: decode false")
                return
            }
            DispatchQueue.main.async {
                self.machiawaseInfo = machiawaseInfoResponse
                self.eventInfoList = self.getEventInfoList()
                self.machiawaseUserMe = self.getMachiawaseUserMe()
                self.partnerProgressList = self.getPartnerProgressList()
                self.selectedPartnerProgress = self.getMyPartnerProgress()
                print("デバッグ: \(self.machiawaseInfo)")
            }
        }
        task.resume()
    }
    
    /// 待ち合わせユーザから自分自身を探す
    func getMachiawaseUserMe() -> MachiawaseUser? {
        let filteredMachiawaseUserMe = machiawaseInfo?.machiawase.machiawaseUser.filter { machiawaseUser in
            let ownerName = UserDefaults.standard.string(forKey: "owner_name")
            return machiawaseUser.user.userName == ownerName
        }
        let machiawaseUserMe = filteredMachiawaseUserMe?.first
        return machiawaseUserMe
    }
    
    /// イベント一覧を取得する
    func getEvents() -> [Event] {
        guard let userEvents = getMachiawaseUserMe()?.events else { return [] }
        return userEvents
    }
    
    /// タスクの一覧を取得する
    func getPartnerProgressList() -> [PartnerProgress] {
        guard let machiawaseUsers = machiawaseInfo?.machiawase.machiawaseUser else { return [] }
        let partnerProgressList = machiawaseUsers.map {
            let doneEventCount = Double($0.events.filter({ $0.progress == "done" }).count)
            let eventCount = Double($0.events.count)
            let doneRate = Double(doneEventCount / eventCount)
            return PartnerProgress(name: $0.user.userName, moveMode: "徒歩", arrivalDate: machiawaseInfo?.machiawase.appointmentDatetime ?? "", progressRate: doneRate)
        }
        return partnerProgressList
    }
    
    /// 自分のPartnerProgressを取得する
    func getMyPartnerProgress() -> PartnerProgress {
        guard let me = getMachiawaseUserMe() else {
            return PartnerProgress(name: "", moveMode: "", arrivalDate: "", progressRate: 0)
        }
        let myPartnerProgress = getPartnerProgressList().filter {
            $0.name == me.user.userName
        }.first
        guard let myPartnerProgress = myPartnerProgress else {
            return PartnerProgress(name: "", moveMode: "", arrivalDate: "", progressRate: 0)
        }
        return myPartnerProgress
    }

    
    /// イベント一覧からEventCell一覧を取得する
    func getEventInfoList() -> [EventInfo] {
        let eventInfoList = getEvents().map {
            EventInfo(
                name: $0.shitakuItem.shitakuItemName,
                time:$0.shitakuItem.shitakuItemTime,
                timeLeft: $0.timeLeft,
                progress: EventInfo.Progress(rawValue: $0.progress) ?? .not_yet
            )
        }
        return eventInfoList.reversed()
    }

    
    /// セルの位置を取得する
    /// - Parameter index: セルのindex
    /// - Returns: セルの位置
    func getCellPosition(_ index: Int) -> CellPosition {
        switch index {
        case 0: return .top
        case eventInfoList.count - 1: return .bottom
        default: return .center
        }
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
