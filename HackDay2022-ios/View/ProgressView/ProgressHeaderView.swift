//
//  ProgressHeaderView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/16.
//

import SwiftUI

// 進捗画面のヘッダー
struct ProgressHeaderView: View {
    
    var viewModel: ProgressViewModel
    
    var text: (time: String, address: String) {
        guard let machiawase = viewModel.machiawaseInfo?.machiawase else { return ("", "") }
        let dateString = machiawase.appointmentDatetime
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let localDate = formatter.date(from: dateString + "-09:00")

//        formatter.dateStyle = .none
//        formatter.timeZone = .short
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //2022-09-17T18:42:23
//        formatter.locale = Locale.init(identifier: "ja_JP")
//        let date = formatter.date(from: dateString)
        return ("12:00", machiawase.appointmentAddress)
    }
    
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
            Text(text.time)
                .font(.title2)
                .bold() +
            Text(" に ")
                .font(.caption) +
            Text(text.address)
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
    
    private func mainText(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .bold()
    }
    
    private var headerBottomImage: some View {
        Image("progress_header")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
}

struct ProgressHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressHeaderView(viewModel: ProgressViewModel())
            .previewLayout(.fixed(width: 400, height: 140))
    }
}
