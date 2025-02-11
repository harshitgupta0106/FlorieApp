//
//  SwiftUIView.swift
//  Svaraa-app
//
//  Created by Harshit Gupta on 06/02/25.
//
// SvaraaTalkView.swift
import SwiftUI

struct SvaraaTalkView: View {
    @State private var messages: [Message] = []
    @State private var inputText: String = ""
    @State private var scrollProxy: ScrollViewProxy? = nil
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image("App-Logo")
                .resizable()
                .cornerRadius(25)
                .frame(width: 200, height: 200)
            if messages.isEmpty {
                VStack(alignment: .leading, spacing: 5.0) {
                    
                    Text("Hello, \(DataController.shared.getUserName())")
                        .font(.largeTitle)
                    Text("How can I help you?")
                        .font(.largeTitle)
                }
                Spacer()
            } else {
                ScrollViewReader { proxy in
                    List {
                        ForEach(messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.indigo)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    VStack {
                                        Spacer()
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .foregroundStyle(.indigo)
                                            .frame(width: 25, height: 25)
                                            .padding(.bottom, 6)
                                    }
                                } else {
                                    VStack {
                                        Spacer()
                                        Image("App-Logo")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.bottom, 6)
                                            .padding(.leading, -10)
                                    }
                                    Text(message.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }
                            .id(message.id)  // Required for ScrollViewReader
                        }
                    }
                    .onAppear {
                        scrollProxy = proxy
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .onChange(of: messages) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Let's talk with Svaraa", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        if !inputText.isEmpty {
                            sendMessage()
                        }
                    }
                Button("Send") {
                    if !inputText.isEmpty {
                        sendMessage()
                    }
                }
            }
            .padding()
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    
    private func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let userMessage = Message(text: inputText, isUser: true)
        if inputText == "/clear" {
            messages.removeAll()
            inputText = ""
            return
        }
        messages.append(userMessage)
        
        messages.append(Message(text: "Svaraa is thinking.", isUser: false))
        let botResponse = Message(text: getBotResponse(for: inputText), isUser: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            messages.removeLast()
            if messages.count == 1 {
                messages.append(Message(text: "Svaraa here, \(botResponse.text)", isUser: false))
            } else {
                
                messages.append(botResponse)
            }
            generator.impactOccurred()
        }
                
        inputText = ""
        isTextFieldFocused = false
    }
    
    
    private func getBotResponse(for input: String) -> String {
            let lowercasedInput = input.lowercased()
            
            if lowercasedInput.contains("uti") || lowercasedInput.contains("urination") {
                return "UTIs are common. Drink plenty of water and consult a doctor if symptoms persist."
            } else if lowercasedInput.contains("period") || lowercasedInput.contains("menstrual") {
                return "Irregular periods can happen. Track your cycle and consult a doctor if you're concerned."
            } else if lowercasedInput.contains("yeast") || lowercasedInput.contains("itching") {
                return "Yeast infections can cause itching. Avoid scented products and see a doctor if needed."
            } else {
                return "I’m here to help! Let’s talk to a doctor if you’re worried."
            }
        }
}

