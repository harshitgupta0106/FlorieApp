//
//  File.swift
//  Svaraa
//
//  Created by Harshit Gupta on 13/02/25.
//

import Foundation


struct Story {
    let id = UUID()
    let title: String
    var storyScenes: [StoryScene]
    var mcqScene: MCQScene
    var finalScene: StoryScene
}

struct StoryScene {
    let id = UUID()
    let descriptions: [String]
    let backgroundImageName: String
    let svaraaImageName: String
}

struct MCQScene{
    let id = UUID()
    let question: String
    let options: [String]
    let correctOptionIndex: Int
    let backgroundImageName: String
    let svaraaImageName: String
}
