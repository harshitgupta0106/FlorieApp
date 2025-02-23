//
//  File.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
}


struct QuestionCategory: Identifiable {
    let id = UUID()
    let name: String
    let items: [QAItem]
}

struct QAItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}


