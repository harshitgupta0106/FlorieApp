//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 18/02/25.
//

import SwiftUI

struct InitialView: View {
    @Binding var isConversing: Bool
    @Binding var messages: [Message]
    @Binding var isPcodTest: Bool
    @Binding var pcodQuestionIndex: Int
    @Binding var isPcosTest: Bool
    @Binding var pcosQuestionIndex: Int
    
    var responses: [Int] = []
    var body: some View {
        VStack(alignment: .leading, spacing: 40.0) {
            
            VStack(alignment: .leading, spacing: 5.0) {
                Text("Hello, \(DataController.shared.getUserName())")
                    .font(.largeTitle)
                    .foregroundColor(Color.primary)
                Text("How can I help you?")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purple)
                
            }
            HStack {
                Button("Test for PCOD") {
                    isConversing = true
                    isPcodTest = true
                    pcodQuestionIndex = 0 // Reset question index
                    pcodTest()
                }
                .buttonStyle(.borderedProminent)
                Button("Test for PCOS") {
                    isConversing = true
                    isPcosTest = true
                    pcosQuestionIndex = 0
                    pcosTest()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.top, 20.0)
        .onAppear {
            isConversing = false
        }
    }
    
    
    func pcodTest() {
        let questions = DataController.shared.getAllPCODQuestions()
        messages.append(Message(
            text: "Let's start the PCOD Test. \(questions[0])",
            isUser: false
        ))
    }
    
    func pcosTest() {
        let questions = DataController.shared.getAllPCOSQuestions()
        messages.append(Message(
            text: "Let’s begin the PCOS Test! \(questions[0])",
            isUser: false
        ))
    }
    
    
}

