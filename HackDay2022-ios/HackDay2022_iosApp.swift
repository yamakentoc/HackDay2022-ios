//
//  HackDay2022_iosApp.swift
//  HackDay2022-ios
//
//  Created by 山口賢登 on 2022/09/11.
//

import SwiftUI

@main
struct HackDay2022_iosApp: App {
    
    init() {
        // アプリ全体でNavigationBarの色を統一
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(Color.backgroundBaseColor)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().isTranslucent = false
        
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
