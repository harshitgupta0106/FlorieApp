//
//  File.swift
//  Svaraa
//
//  Created by Harshit Gupta on 19/02/25.
//

import Foundation
//import NaturalLanguage
//
//@MainActor
//class Chatbot {
//    private var qaData: [String: String] = [:]
//    private var isDataLoaded = false
//
//    init(completion: @escaping () -> Void) {
//        self.qaData = DataController.shared.getQADictionary()
//        self.isDataLoaded = true
//        completion()
//    }
//
//    func getResponse(for userInput: String) -> String {
//        guard isDataLoaded else {
//            return "I'm still loading, please wait..."
//        }
//
//        if let exactAnswer = qaData[userInput] {
//            return exactAnswer
//        }
//
//        let embedding = NLEmbedding.sentenceEmbedding(for: .english)
//        var bestMatch: String? = nil
//        var highestSimilarity: Double = 0.0
//
//        for (question, answer) in qaData {
//            if let similarity = embedding?.distance(between: userInput, and: question) {
//                if similarity > highestSimilarity {
//                    highestSimilarity = similarity
//                    bestMatch = answer
//                }
//            }
//        }
//
//        return (highestSimilarity > 0.7) ? bestMatch ?? "I can't help with that." : "I can't help with that."
//    }
//}
import NaturalLanguage

@MainActor
class Chatbot {
    private var qaData: [String: String] = [:]
    private var isDataLoaded = false

    init() {
        self.qaData = DataController.shared.getQADictionary()
        self.isDataLoaded = true
    }

    func getResponse(for userInput: String) -> String {
        guard isDataLoaded else {
            return "I'm still loading, please wait..."
        }

        if let exactAnswer = qaData[userInput] {
            print("Exact answer: \(exactAnswer)")
            return exactAnswer
        }

        let embedding = NLEmbedding.sentenceEmbedding(for: .english)
        var bestMatch: String? = nil
        var highestSimilarity: Double = 0.0

        for (question, answer) in qaData {
            if let similarity = embedding?.distance(between: userInput, and: question) {
                if similarity > highestSimilarity {
                    highestSimilarity = similarity
                    bestMatch = answer
                }
            }
        }
        print("Match: \(String(describing: bestMatch))")
        print("Similarity: \(highestSimilarity)")
        
        return (highestSimilarity > 0.5) ? bestMatch ?? "I can't help with that." : "I can't help with that."
    }
}


