//
//  SwiftUIView.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//
// FlorieTalkView.swift
import SwiftUI

struct FlorieTalkView: View {
    @State private var messages: [Message] = []
    @State private var inputText: String = ""
    @State private var scrollProxy: ScrollViewProxy? = nil
    @FocusState private var isTextFieldFocused: Bool
    
    var username = "Harshit" // To add dynamically
    
    var body: some View {
        VStack {
            Spacer()
            Image("Florie-logo")
//                        .renderingMode(.original)
                .resizable()
                .frame(width: 200, height: 200)
            if messages.isEmpty {
                VStack(alignment: .leading, spacing: 5.0) {
                    
                    Text("Hello \(username)")
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
                                        .background(Color.pink)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    VStack {
                                        Spacer()
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .foregroundStyle(.pink)
                                            .frame(width: 25, height: 25)
                                            .padding(.bottom, 6)
                                    }
                                } else {
                                    VStack {
                                        Spacer()
                                        Image("Florie-logo")
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
                TextField("Let's talk with Florie", text: $inputText)
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
        
        messages.append(Message(text: "Florie is thinking.", isUser: false))
        let botResponse = Message(text: getBotResponse(for: inputText), isUser: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            messages.removeLast()
            if messages.count == 1 {
                messages.append(Message(text: "Florie here, \(botResponse.text)", isUser: false))
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

