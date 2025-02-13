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
                .scaledToFit()
                .cornerRadius(25)
                .frame(width: 100, height: 100)
            if messages.isEmpty {
                InitialView()
                Spacer()
            } else {
                ScrollViewReader { proxy in
                    List {
                        ForEach(messages) { message in
                            MessagesView(message: message)
                        }
                    }
                    .animation(.smooth, value: true)
                    .listStyle(.plain)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...2)) {
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


struct InitialView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            
            Text("Hello, \(DataController.shared.getUserName())")
                .font(.largeTitle)
                .foregroundColor(Color.yellow)
                
            
            
            Text("How can I help you?")
                .font(.body)
        }
        .padding(.top, 20.0)
    }
}

struct UserImageAsideMessages: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .foregroundStyle(.indigo)
                .frame(width: 25, height: 25)
                .padding(.bottom, 6)
        }
    }
}

struct SvaraaImageAsideMessages: View {
    var body: some View {
        VStack {
            Spacer()
            Image("App-Logo")
                .resizable()
                .frame(width: 25, height: 25)
                .cornerRadius(12.5)
                .padding(.bottom, 6)
                .padding(.leading, -10)
        }
    }
}

struct MessagesView: View {
    var message: Message
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                UserImageAsideMessages()
            } else {
                SvaraaImageAsideMessages()
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
            }
        }
        .listRowSeparator(.hidden)
        .id(message.id)
    }
}

//To preview, this code will be written

#Preview {
    SvaraaTalkView()
}
