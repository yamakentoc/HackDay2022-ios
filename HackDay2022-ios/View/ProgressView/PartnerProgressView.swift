//
//  PartnerProgressView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/13.
//

import SwiftUI

/// みんなの様子画面
struct PartnerProgressView: View {
    /// みんなの様子画面のViewModel
    @StateObject var viewModel: PartnerProgressViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ProgressHeaderView(meetingInfo: viewModel.meetingInfo)
            gauges
            currentProgressView(viewModel.selectedPartnerProgress)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.backgroundBaseColor)
    }
    
    /// 縦型のゲージ
    private var gauges: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 30)
            HStack(spacing: 100) {
                ForEach(viewModel.partnerProgessList) { progress in
                    // カスタムゲージを作成して表示する
                    Gauge(value: 400, in: 0...400) {
                    } currentValueLabel: {}
                        .gaugeStyle(CustomGaugeStyle(viewModel: viewModel, partnerProgress: progress))
                        .onTapGesture {
                            viewModel.showSelectedPartnerProgressData(progress: progress)
                        }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            Image("partner_progress_background")
                .resizable()
        }
    }
    
    /// 現在の値を示すView
    func currentProgressView(_ progress: PartnerProgress) -> some View {
        VStack(spacing: 0) {
            Triangle()
                .fill(Color.white)
                .frame(width: 30, height: 35)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 90)
                .padding(.horizontal)
                .overlay {
                    VStack(alignment: .leading) {
                        UserNameView(name: progress.name, isSelected: true)
                        HStack(spacing: 4) {
                            Image("partner_move_walk")
                            Text("\(progress.moveMode)で移動中")
                                .font(.title3)
                            Spacer()
                                .frame(width: 20)
                            Image("partner_clock")
                            Text("\(progress.arrivalDate)")
                                .font(.title)
                                .bold()
                            VStack {
                                Text("到着")
                                Text("予定")
                            }
                            .font(.caption)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
        }
    }
    
    
    /// 縦型のゲージスタイル
    private struct CustomGaugeStyle: GaugeStyle {
        /// みんなの様子画面のViewModel
        @StateObject var viewModel: PartnerProgressViewModel
        /// 相手の進捗状況
        var partnerProgress: PartnerProgress
        /// 最大値
        let maximumValue: Double = 400.0
        
        func makeBody(configuration: Configuration) -> some View {
            ZStack {
                ProgressView()
            }
        }
        
        /// 最大値用と現在値用のProgressViewを生成する
        /// - Returns: 最大値用と現在値用のProgressView
        private func ProgressView() -> some View {
            ZStack(alignment: .bottom) {
                ProgressBar(value: maximumValue, isBack: true)
                ProgressBar(value: partnerProgress.progressRate, isBack: false)
            }
        }
        
        /// 縦型のProgressBarを生成
        /// - Parameters:
        ///   - value: 現在の値
        ///   - isBack: 背景用か
        /// - Returns: 縦型のProgressBar
        private func ProgressBar(value: Double, isBack: Bool) -> some View {
            RoundedRectangle(cornerRadius: 20)
                .fill(isBack ? .white : .componentSeekbarColor)
                .frame(width: 30, height: isBack ? maximumValue : value)
                .overlay {
                    if !isBack {
                        if value == maximumValue {
                            VStack {
                                Image("partner_progress_complete")
                                UserNameView(name: partnerProgress.name, isSelected: viewModel.isSelectedPartnerProgress(partnerProgress))
                            }
                            .position(x: 15, y: -50)
                        } else {
                            VStack {
                                Image("partner_progress_complete_not")
                                UserNameView(name: partnerProgress.name, isSelected: viewModel.isSelectedPartnerProgress(partnerProgress))
                            }
                            .position(x: 15, y: 0)
                        }
                    }
                }
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        PartnerProgressView(viewModel: PartnerProgressViewModel())
    }
}
