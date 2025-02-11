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
            // Tab 1: Svaraa's Life (Game)
            SvaraaLifeView()
                .tabItem {
                    Label("Svaraa's Life", systemImage: "dpad.fill")
                }
            
            // Tab 2: Svaraa's Talk (AI Chatbot)
            SvaraaTalkView()
                .tabItem {
                    Label("Svaraa's Talk", systemImage: "ellipsis.message.fill")
                }
            
            // Tab 3: Svaraa's Logs (Health Data)
            SvaraaLogsView()
                .tabItem {
                    Label("Svaraa's Logs", systemImage: "chart.bar.doc.horizontal")
                }
        }
//        .accentColor(Color(hue: 330, saturation: 89, brightness: 83)) // Match your app's theme
    }
}
