//
//  CreateMeetingScheduleViewModel.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/17.
//

import Foundation

/// 待ち合わせ予定
struct MeetingSchedule: Codable {
    var appointment_datetime: String = ""
    var appointment_address: String = "東京駅"
    var member: [String] = ["じーこ", "やまけん"]
    var owner_name: String = ""
    var shitaku_myset_name: String = "メイクテキトーな日"
}

class CreateMeetingScheduleViewModel: ObservableObject {
    /// 待ち合わせ予定のデータ
    @Published var meetingSchedule: MeetingSchedule = MeetingSchedule()
    
    /// 選択された時間
    @Published var selectedDate: Date = Date() {
        didSet {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            meetingSchedule.appointment_datetime = formatter.string(from: selectedDate)
        }
    }
    
    init() {
        #if DEBUG
        meetingSchedule.owner_name = "やまけん"
        UserDefaults.standard.set(meetingSchedule.owner_name, forKey: "owner_name")
        #endif
    }
    
    /// 仕様上owner_nameに連続して同じ名前が来ると整合性が取れないので毎回異なる名前を入れる
    func setOwnerNameForDebug() {
        if let name = UserDefaults.standard.string(forKey: "owner_name") {
            let newName: String
            if name == "しゅーぞー" {
                newName = "やまけん"
            } else {
                newName = "しゅーぞー"
            }
            UserDefaults.standard.set(newName, forKey: "owner_name")
            meetingSchedule.owner_name = newName
        } else {
            let name = "しゅーぞー"
            UserDefaults.standard.set(name, forKey: "owner_name")
            meetingSchedule.owner_name = name
        }
    }
    
    /// 待ち合わせ予定をポストする
    func postMeetingScheduleData() {
        addSelectedDateIfNeed()
        let url = URL(string: "https://orange-gembaneko.de.r.appspot.com/appointment/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")

        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(meetingSchedule)
            request.httpBody = jsonData
        } catch let encodeError as NSError {
            print("post error: \(encodeError)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard data != nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("post: no data or status code not created")
                return
            }
            print("post: success")
        }
        task.resume()
    }
    
    /// appointment_datetimeに何も入ってない場合
    func addSelectedDateIfNeed() {
        if meetingSchedule.appointment_datetime == "" {
            selectedDate = Date()
        }
        
    }
    
}
