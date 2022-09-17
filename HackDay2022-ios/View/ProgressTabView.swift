//
//  RootTabView.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/13.
//

import SwiftUI

/// Progressのタブ
struct ProgressTabView: View {
    /// 選択中のタブ
    @State var selectedTab = 1
    
    var body: some View {
        VStack(spacing: 0) {
            TabButtonView
            TopTabBar
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarHidden(true)
    }
    
    /// TabのButtonをまとめたView
    private var TabButtonView: some View {
        HStack(spacing: 0) {
            TabButton(target: "自分の準備", tag: 1)
            TabButton(target: "みんなの様子", tag: 2)
        }
        .background(Color.backgroundBaseColor)
    }
    
    
    /// TabのButton
    /// - Parameters:
    ///   - target: 自分 or 相手
    ///   - tag: 設定するタグ
    /// - Returns: TabのButton
    private func TabButton(target: String, tag: Int) -> some View {
        Text(target)
            .bold()
            .frame(maxWidth: .infinity)
            .foregroundColor(.textPrimaryLightColor)
            .padding(.bottom, 8)
            .background {
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 2)
                        .padding(.horizontal, 10)
                        .foregroundColor(selectedTab == tag ? .textPrimaryLightColor : .clear)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                selectedTab = tag
            }
    }
    
    /// 上部に表示するTabBar
    private var TopTabBar: some View {
        TabView(selection: $selectedTab) {
            MyProgressView(viewModel: MyProgressViewModel())
                .tag(1)
            PartnerProgressView(viewModel: PartnerProgressViewModel())
                .tag(2)
        }
        .tabViewStyle(.page)
    }
    
}

struct ProgressTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressTabView()
    }
}
