//
//  MyProgressView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/11.
//

import SwiftUI

/// 自分の進捗画面
struct MyProgressView: View {
    @StateObject var viewModel: MyProgressViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ProgressHeaderView(meetingInfo: viewModel.meetingInfo)
                    ForEach(Array(viewModel.taskList.enumerated()), id: \.offset) { index, element in
                        TaskCell(task: element,
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
                    Text("5")
                        .font(.title)
                        .bold()
                        .foregroundColor(.textEarlyColor) +
                    Text("分")
                }
                VStack(spacing: 6) {
                    Text("予定より")
                        .bold()
                    Text("1 ")
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

/// タスクを表示するセル
private struct TaskCell: View {
    // 表示するタスク
    var task: Task
    // セルの位置
    var cellPotision: CellPosition
    // 背景色
    var backgroundColor: Color

    var body: some View {
        HStack(spacing: 16) {
            progressImage
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                    .bold()
                Label(title: {
                    Text("\(task.time)分")
                }, icon: {
                    Image(systemName: "timer")
                })
                .font(.callout)
            }
            .opacity(task.progress == .done ? 0.5 : 1)
            Spacer()
            if task.progress == .now {
                timer
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .background(backgroundColor)
    }
    
    /// 進捗画像
    private var progressImage: some View {
        Image(task.progress.getImageString(cellPotision))
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
    static var task = Task(name: "ヘアセット", time: "10", progress: .now)
    static var previews: some View {
        MyProgressView(viewModel: MyProgressViewModel())
        TaskCell(task: task, cellPotision: .center, backgroundColor: .backgroundBaseColor)
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
