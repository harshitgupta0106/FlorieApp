//
//  File.swift
//  Svaraa
//
//  Created by Harshit Gupta on 16/02/25.
//

import SwiftUI

enum SvaraaTab: String {
    case talk, life, logs
}

@Observable
@MainActor
class SvaraaApp: ObservableObject {
    static var shared = SvaraaApp()
    var selectedTab: SvaraaTab = .talk

    static func openTab(_ tab: SvaraaTab) {
        shared.selectedTab = tab
    }
}
