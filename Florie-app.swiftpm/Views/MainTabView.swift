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
            // Tab 1: Florie's Life (Game)
            FlorieLifeView()
                .tabItem {
                    Label("Florie's Life", systemImage: "dpad.fill")
                }
            
            // Tab 2: Florie's Talk (AI Chatbot)
            FlorieTalkView()
                .tabItem {
                    Label("Florie's Talk", systemImage: "ellipsis.message.fill")
                }
            
            // Tab 3: Florie's Logs (Health Data)
            FlorieLogsView()
                .tabItem {
                    Label("Florie's Logs", systemImage: "chart.bar.doc.horizontal")
                }
        }
        .accentColor(.purple) // Match your app's theme
    }
}
