//
//  CreateMeetingSchedule.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/17.
//

import SwiftUI
/// 待ち合わせ予定を作成画面
struct CreateMeetingSchedule: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: CreateMeetingScheduleViewModel
    
    @State var transportationText = "交通手段を選択"
    // メンバー
    @State var memberText1 = ""
    @State var memberText2 = ""
    @State var memberText3 = ""
    
    // マイセット
    @State var myset = "したくマイセットを選択"
    
    
    var body: some View {
        VStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 30) {
                    dateView
                    placeView
                    transportationView
                    memberView
                    mysetView
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .navigationBarTitle("待ち合わせ予定を作成", displayMode: .inline)
            .setNavigationBackButton()
            bottomButtonView
        }
    }
    
    /// 日時
    private var dateView: some View {
        VStack(alignment: .leading) {
            Label("日時", image: "schedule_calendar")
                .labelStyle(ScheduleLabelStyle())
            DatePicker("", selection: $viewModel.selectedDate)
                .labelsHidden()
        }
    }
    
    /// 場所
    private var placeView: some View {
        VStack(alignment: .leading) {
            Label("場所", image: "schedule_position")
                .labelStyle(ScheduleLabelStyle())
            TextField("", text: $viewModel.meetingSchedule.appointment_address)
                .setScheduleTextFieldStyle(placeholder: "東京駅前",
                                           inputText: viewModel.meetingSchedule.appointment_address)
        }
    }
    
    /// 交通手段
    private var transportationView: some View {
        VStack(alignment: .leading) {
            Label("交通手段", image: "schedule_car")
            menu(text: $transportationText, menuList:  ["徒歩", "徒歩", "徒歩"])// ["徒歩", "車", "自転車"])
        }
    }
    
    /// メンバー
    private var memberView: some View {
        VStack(alignment: .leading) {
            Label("メンバー", image: "schedule_member")
                .labelStyle(ScheduleLabelStyle())
            TextField("", text: $memberText1)
                .setScheduleTextFieldStyle(placeholder: "名前", inputText: memberText1)
            Spacer().frame(height: 16)
            TextField("", text: $memberText2)
                .setScheduleTextFieldStyle(placeholder: "名前", inputText: memberText2)
            Spacer().frame(height: 16)
            TextField("", text: $memberText3)
                .setScheduleTextFieldStyle(placeholder: "名前", inputText: memberText3)
        }
    }
    /// したくマイセット
    private var mysetView: some View {
        VStack(alignment: .leading) {
            Label("したくマイセット", image: "schedule_myset")
            menu(text: $myset, menuList: ["メイクテキトーな日"])
        }
    }
    
    /// メニューを表示する
    private struct menu: View {
        /// 内容を変更するText
        @Binding var text: String
        
        var menuList: [String]
        
        var body: some View {
            ZStack {
                Menu {
                    ForEach(0..<menuList.count, id: \.self) { i in
                        Button(menuList[i], action: { text = menuList[i] })
                    }
                } label: {
                    Text(text)
                        .foregroundColor(.textPrimaryLightColor)
                        .padding(6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.textPrimaryLightColor, lineWidth: 2)
                        }
                }
                Triangle()
                    .fill(Color.textPrimaryLightColor)
                    .frame(width: 10, height: 8)
                    .rotationEffect(.degrees(180))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                
            }
        }
    }
    
    /// 画面下部のボタン
    private var bottomButtonView: some View {
        HStack {
            bottomButton(text: "キャンセル",
                         foreColor: .textPrimaryLightColor,
                         backColor: .componentTertiaryColor)
            NavigationLink(destination: ProgressTabView()) {
                bottomButton(text: "登録",
                             foreColor: .white,
                             backColor: .componentPrimaryColor)
            }
            // NavigationLinkに.onTapGestureを使用すると遷移できない問題の回避策
            .simultaneousGesture(TapGesture().onEnded {
                viewModel.postMeetingScheduleData()
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .frame(height: 80)
        .background(Color.backgroundBaseColor)
    }
    
    private func bottomButton(text: String, foreColor: Color, backColor: Color) -> some View {
        Text(text)
            .padding()
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundColor(foreColor)
            .background(backColor)
            .cornerRadius(20)
    }
}

struct CreateMeetingSchedule_Previews: PreviewProvider {
    static var previews: some View {
        CreateMeetingSchedule(viewModel: CreateMeetingScheduleViewModel())
    }
}
