//
//  File.swift
//  Svaraa
//
//  Created by Harshit Gupta on 13/02/25.
//

import Foundation

struct GameScene {
    let id = UUID()
    let description: String
    let backgroundImageName: String
    let svaraaImageName: String
    let choices: [Choice]?
    let nextSceneID: UUID?
}

struct Choice {
    let id = UUID()
    let text: String
    let nextSceneID: UUID
    let outcome: String
    let healthTip: String
}
