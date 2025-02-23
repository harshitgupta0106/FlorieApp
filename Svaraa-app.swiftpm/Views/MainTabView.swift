//
//  File.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//

// MainTabView.swift
import SwiftUI



struct MainTabView: View {
    @StateObject private var appState = SvaraaApp.shared
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            SvaraaTalkView()
                .tabItem {
                    Label("Svaraa's Talk", systemImage: "ellipsis.message.fill")
                }
                .tag(SvaraaTab.talk)
            
            SvaraaLifeView()
                .tabItem {
                    Label("Svaraa's Life", systemImage: "dpad.fill")
                }
                .tag(SvaraaTab.life)
            
            SvaraaLogsView()
                .tabItem {
                    Label("Svaraa's Plan", systemImage: "chart.bar.doc.horizontal")
                }
                .tag(SvaraaTab.logs)
        }
        .navigationBarBackButtonHidden()
    }
}
