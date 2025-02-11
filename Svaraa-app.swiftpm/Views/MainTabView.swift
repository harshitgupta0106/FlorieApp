//
//  File.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//

// MainTabView.swift
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SvaraaLifeView()
                .tabItem {
                    Label("Svaraa's Life", systemImage: "dpad.fill")
                }
            SvaraaTalkView()
                .tabItem {
                    Label("Svaraa's Talk", systemImage: "ellipsis.message.fill")
                }
            SvaraaLogsView()
                .tabItem {
                    Label("Svaraa's Logs", systemImage: "chart.bar.doc.horizontal")
                }
        }
    }
}
