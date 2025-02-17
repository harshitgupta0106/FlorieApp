//
//  File.swift
//  Svaraa
//
//  Created by Harshit Gupta on 16/02/25.
//

import AppIntents

struct StartGameIntent: AppIntent {
    static let title: LocalizedStringResource = "Start Svaraa’s Health Game"
    static let description = IntentDescription("Opens the Svaraa’s Life tab to play the health game.")

    func perform() async throws -> some IntentResult & ProvidesDialog {
        await SvaraaApp.openTab(SvaraaTab.life)
        return .result(dialog: "Opening Svaraa’s Health Game!")
    }
    
    static let openAppWhenRun: Bool = true
}


struct StartChatIntent: AppIntent {
    static let title: LocalizedStringResource = "Start chat with Svaraa"
    static let description = IntentDescription("Let's you start a chat with Svaraa.")

    func perform() async throws -> some IntentResult & ProvidesDialog {
        await SvaraaApp.openTab(SvaraaTab.talk)
        return .result(dialog: "Opening Svaraa’s Talk!")
    }
    
    static let openAppWhenRun: Bool = true
}


struct StartLogIntent: AppIntent {
    static let title: LocalizedStringResource = "Start log with Svaraa"
    static let description = IntentDescription("Let's you log an entry with Svaraa")

    func perform() async throws -> some IntentResult & ProvidesDialog {
        await SvaraaApp.openTab(SvaraaTab.logs)
        return .result(dialog: "Opening Svaraa’s Log!")
    }
    
    static let openAppWhenRun: Bool = true
}






