//
//  MyProgressView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/11.
//

import SwiftUI

/// 自分の進捗画面
struct MyProgressView: View {
    @EnvironmentObject var viewModel: ProgressViewModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ProgressHeaderView(viewModel: viewModel)
                    ForEach(Array(viewModel.eventInfoList.enumerated()), id: \.offset) { index, element in
                        EventCell(event: element,
                                  cellPotision: viewModel.getCellPosition(index),
                                  backgroundColor: index % 2 == 0 ? .backgroundListColor : .backgroundBaseColor)
                    }
                    Spacer()
                }
            }
            HStack(spacing: 40) {
                VStack(spacing: 6) {
                    Text("家を出るまで")
                        .bold()
                    Text("あと") +
                    Text(String(viewModel.machiawaseUserMe?.leaveAt ?? 0))
                        .font(.title)
                        .bold()
                        .foregroundColor(.textEarlyColor) +
                    Text("分")
                }
                VStack(spacing: 6) {
                    Text("予定より")
                        .bold()
                    Text(String(viewModel.machiawaseUserMe?.expectedDiff ?? 0))
                        .font(.title)
                        .bold()
                        .foregroundColor(.textEarlyColor) +
                    Text("分") +
                    Text("早い")
                        .bold()
                        .foregroundColor(.textEarlyColor)
                }
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .background(Color.backgroundBaseColor)
    }
}

/// イベントを表示するセル
private struct EventCell: View {
    // 表示するイベント
    var event: EventInfo
    // セルの位置
    var cellPotision: CellPosition
    // 背景色
    var backgroundColor: Color

    var body: some View {
        HStack(spacing: 16) {
            progressImage
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                    .bold()
                Label(title: {
                    Text("\(event.time)分")
                }, icon: {
                    Image(systemName: "timer")
                })
                .font(.callout)
            }
            .opacity(event.progress == .done ? 0.5 : 1)
            Spacer()
            if event.progress == .doing {
                timer
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .background(backgroundColor)
    }

    /// 進捗画像
    private var progressImage: some View {
        Image(event.progress.getImageString(cellPotision))
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }

    /// タイマー
    private var timer: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text("あと")
                .font(.system(size: 16))
            Gauge(value: 60, in: 0...100) {
            } currentValueLabel: {
                HStack(alignment: .bottom ,spacing: 0) {
                    Text("1")
                        .font(.system(size: 18))
                    Text("分")
                        .font(.system(size: 12))
                }
                .fontWeight(.black)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.componentSecondaryColor)
            .frame(height: 50)
        }
    }
}

struct MyProgressView_Previews: PreviewProvider {
    static var event = EventInfo(name: "ヘアセット", time: 10, timeLeft: 5, progress: .doing)
    static var previews: some View {
        MyProgressView().environmentObject(ProgressViewModel())
        EventCell(event: event, cellPotision: .center, backgroundColor: .backgroundBaseColor)
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
