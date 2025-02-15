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
    @State var isConversing: Bool = false
    @State private var inputText: String = ""
    @State private var scrollProxy: ScrollViewProxy? = nil
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            GradientChatBot(isConversing: $isConversing)
            VStack {
                Spacer()
                Image("App-Logo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(25)
                    .frame(width: 100, height: 100)
                
                    .animation(.bouncy(duration: 4), value: isConversing)
                    .if(!isConversing) { view in
                            view.shadow(color: Color.purple, radius: 75, x: 3, y: 3)
                    }
                if messages.isEmpty {
                    InitialView(isConversing: $isConversing)
                    Spacer()
                } else {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(messages) { message in
                                MessagesView(message: message)
                                    .listRowBackground(Color.clear)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
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
                                //sending message & handling animation
                                isConversing = sendMessage()
                            }
                        }
                    Button("Send") {
                        if !inputText.isEmpty {
                            isConversing = sendMessage()
                        }
                    }
                }
                .padding()
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    
    private func sendMessage() -> Bool{
        guard !inputText.isEmpty else { return false }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let userMessage = Message(text: inputText, isUser: true)
        messages.append(userMessage)
        if inputText.lowercased().contains("bye") {
            inputText = ""
            isTextFieldFocused = false
            messages.append(Message(text: "B-bye, \(DataController.shared.getUserName())!", isUser: false))
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                messages.removeAll()
                generator.impactOccurred()
            }
            return false
        }
        
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
        return true
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
    @Binding var isConversing: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            
            Text("Hello, \(DataController.shared.getUserName())")
                .font(.largeTitle)
                .foregroundColor(Color.primary)
            Text("How can I help you?")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.purple)
        }
        .padding(.top, 20.0)
        .onAppear {
            isConversing = false
        }
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

struct GradientChatBot: View {
    @Binding var isConversing: Bool
    var body: some View {
        let color = !isConversing ? Color.purple : Color.clear
        LinearGradient(
            gradient: Gradient(colors: [
                color.opacity(0.5),
                color.opacity(0.1),
                color.opacity(0)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 1), value: isConversing)
    }
}

#Preview {
    SvaraaTalkView()
}

