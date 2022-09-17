//
//  ProgressHeaderView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/16.
//

import SwiftUI

// 進捗画面のヘッダー
struct ProgressHeaderView: View {
    var meetingInfo: MeetingInfo
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 16)
            meetingInfoText
            Spacer()
            headerBottomImage
        }
        .frame(height: 150)
        .background(Color.white)
    }
    
    /// 集合の情報テキスト
    private var meetingInfoText: some View {
        HStack {
            Image("progress_flag")
            Text(meetingInfo.time)
                .font(.title2)
                .bold() +
            Text(" に ")
                .font(.caption) +
            Text(meetingInfo.point)
                .font(.title2)
                .bold() +
            Text(" に")
                .font(.caption) +
            Text("集合")
        }
        .foregroundColor(.textPrimaryLightColor)
        .padding(.horizontal, 60)
        .padding(.vertical, 10)
        .background {
            Rectangle()
                .foregroundColor(.componentTertiaryColor)
                .cornerRadius(20)
        }
    }
    
    private var headerBottomImage: some View {
        Image("progress_header")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
}

struct ProgressHeaderView_Previews: PreviewProvider {
    static var meetingInfo = MeetingInfo(time: "10:00",
                                         point: "渋谷駅",
                                         transportation: "車で40分",
                                         member: "やまけん じーこ",
                                         prepareMySet: "メイクテキトーの日")
    static var previews: some View {
        ProgressHeaderView(meetingInfo: meetingInfo)
            .previewLayout(.fixed(width: 400, height: 140))
    }
}
