//
//  TopView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/17.
//

import SwiftUI

/// ルートの画面
struct RootView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("top")
                    .resizable()
                    .scaledToFill()
                VStack {
                    Spacer()
                    NavigationLink(destination: CreateMeetingSchedule(viewModel: CreateMeetingScheduleViewModel())) {
                        // 本来はボタンタップで遷移させる
                        Text("")
                            .frame(maxWidth: .infinity)
                            .frame(height: 400)
                    }
                }
                
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
