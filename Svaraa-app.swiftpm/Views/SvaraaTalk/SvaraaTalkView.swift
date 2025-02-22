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
    @State var isPcodTest = false
    @State private var pcodQuestionIndex = 0
    @State private var pcodResponses: [String] = []
    @State private var showPcodResult = false
    @State var isPcosTest = false
    @State private var pcosQuestionIndex = 0
    @State private var pcosResponses: [String] = []
    @State private var showPcosResult = false
    
    var body: some View {
        ZStack {
            GradientChatBot(isConversing: $isConversing)
            VStack {
                Spacer()
                HStack(alignment: .top, spacing: 60) {
                    Button(action: {
                        messages.removeAll()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                    .padding([.trailing, .top, .bottom])
                    .padding(.leading, 10)
                    .if(!isConversing) { view in
                        view.hidden()
                    }
                    Image("App-Logo")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(25)
                        .frame(width: 100, height: 100)
                        .animation(.bouncy(duration: 4), value: isConversing)
                        .if(!isConversing) { view in
                            view.shadow(color: Color.purple, radius: 75, x: 3, y: 3)
                        }
                    Spacer()
                    Spacer()
                }
                if messages.isEmpty {
                    InitialView(isConversing: $isConversing, messages: $messages, isPcodTest: $isPcodTest, pcodQuestionIndex: $pcodQuestionIndex, isPcosTest: $isPcosTest, pcosQuestionIndex: $pcosQuestionIndex)
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
                        .onChange(of: messages) { _, _ in
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
    
    private func sendMessage() -> Bool {
        guard !inputText.isEmpty else { return false }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let userMessage = Message(text: inputText, isUser: true)
        messages.append(userMessage)
        
        if isPcodTest {
            handlePcodTestResponse()
            inputText = ""
            isTextFieldFocused = false
            return true
        }
        
        // In the sendMessage() function, add this check:
        if isPcosTest {
            handlePcosTestResponse()
            inputText = ""
            isTextFieldFocused = false
            return true
        }
        
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
        
//        getBotResponse(for: inputText) { response in
//            botResponse = Message(text: response, isUser: false)
//            
//            DispatchQueue.main.async {
//                self.messages.append(botResponse) // ✅ Update UI safely
//            }
//        }
        
        let botResponse: String = getBotResponse(for: inputText)
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...2)) {
            messages.removeLast()
//            messages.append(Message(text: botResponse, isUser: false))
            if messages.count == 1 {
                messages.append(Message(text: "Svaraa here, \(botResponse)", isUser: false))
            } else {
                messages.append(Message(text: botResponse, isUser: false))
            }
            generator.impactOccurred()
        }
        
        inputText = ""
        isTextFieldFocused = false
        return true
    }
    
    private func handlePcodTestResponse() {
        let questions = DataController.shared.getAllPCODQuestions()
        pcodResponses.append(inputText)
        
        // Only ask first 4 questions (0-3 index)
        if pcodQuestionIndex < questions.count - 1 {
            pcodQuestionIndex += 1
            messages.append(Message(
                text: questions[pcodQuestionIndex],
                isUser: false
            ))
        } else {
            // Calculate results after 4th question
            let result = calculatePcodResults()
            let riskMessage = getPcodRiskMessage(for: result)
            
            messages.append(Message(
                text: riskMessage,
                isUser: false
            ))
            messages.append(Message(
                text: "Type 'bye' to exit the test",
                isUser: false
            ))
            
            // Reset test state
            isPcodTest = false
            pcodQuestionIndex = 0
            pcodResponses.removeAll()
        }
    }
    
    // Update the calculatePcodResults function with enhanced validation
    private func calculatePcodResults() -> Int {
        guard pcodResponses.count >= 4 else {
            print("Error: Not enough responses")
            return -1
        }
        
        // 1. Validate numerical inputs
        guard let heightCM = Int(pcodResponses[0]), heightCM > 0,
              let weightKG = Int(pcodResponses[1]), weightKG > 0,
              let cycleLength = Int(pcodResponses[2]), cycleLength > 0 else {
            print("Invalid numerical input")
            return -1
        }
        
        // 2. Validate bleeding response
        let bleedingResponse = pcodResponses[3].lowercased()
        guard bleedingResponse == "yes" || bleedingResponse == "no" else {
            print("Invalid bleeding response")
            return -1
        }
        
        // 3. Convert values safely
         let heightMeters = Double(heightCM) / 100.0
         let bmi = Double(weightKG) / pow(heightMeters, 2)
         if (cycleLength > 35 || cycleLength < 21) || bmi < 25 || bleedingResponse == "no" {
             return 0
         }
        return 1
    }
    
    private func getPcodRiskMessage(for result: Int) -> String {
        switch result {
        case 1:
            return "High risk of PCOD detected. Please consult a gynecologist for proper evaluation."
        case 0:
            return "Low risk of PCOD. Maintain a healthy lifestyle!"
        default:
            return "Could not calculate results. Please try again."
        }
    }
    
//    private func getBotResponse(for input: String) -> String {
//        if isPcodTest {
//                let questions = DataController.shared.getAllPCODQuestions()
//                return pcodQuestionIndex < questions.count ? questions[pcodQuestionIndex] : ""
//            }
//        
//        let lowercasedInput = input.lowercased()
//        
//        if lowercasedInput.contains("uti") || lowercasedInput.contains("urination") {
//            return "UTIs are common. Drink plenty of water and consult a doctor if symptoms persist."
//        } else if lowercasedInput.contains("period") || lowercasedInput.contains("menstrual") {
//            return "Irregular periods can happen. Track your cycle and consult a doctor if you're concerned."
//        } else if lowercasedInput.contains("yeast") || lowercasedInput.contains("itching") {
//            return "Yeast infections can cause itching. Avoid scented products and see a doctor if needed."
//        } else {
//            return "I’m here to help! Let’s talk to a doctor if you’re worried."
//        }
//    }
    
    private func getBotResponse(for input: String) -> String {
        if isPcodTest {
            let questions = DataController.shared.getAllPCODQuestions()
            return pcodQuestionIndex < questions.count ? questions[pcodQuestionIndex] : ""
        }
        
        let chatbot = Chatbot()
        let str = chatbot.getResponse(for: input)
        print(str)
        return str
        // Access chatbot to trigger its initialization
//        _ = chatbot
    }




    
    private func handlePcosTestResponse() {
        let questions = DataController.shared.getAllPCOSQuestions()
        pcosResponses.append(inputText)

        if pcosQuestionIndex < questions.count - 1 {
            pcosQuestionIndex += 1
            messages.append(Message(
                text: questions[pcosQuestionIndex],
                isUser: false
            ))
        } else {
            let result = calculatePcosResults()
            let riskMessage = getPcosRiskMessage(for: result)

            messages.append(Message(
                text: riskMessage,
                isUser: false
            ))
            messages.append(Message(
                text: "Type 'bye' to exit the test",
                isUser: false
            ))

            isPcosTest = false
            pcosQuestionIndex = 0
            pcosResponses.removeAll()
        }
    }

    private func calculatePcosResults() -> Int {
        guard pcosResponses.count >= 8 else {
            print("Error: Not enough responses")
            return -1
        }

        var score = 0

        // Assign risk points
        if pcosResponses[0].lowercased().contains("yes") { score += 2 }
        if let weight = Double(pcosResponses[1]), let height = Double(pcosResponses[2]), height > 0 {
            let bmi = weight / (height * height)
            if bmi >= 25 { score += 1 }
        }
        if pcosResponses[3].lowercased().contains("yes") { score += 2 }
        if ["moderate", "severe"].contains(pcosResponses[4].lowercased()) { score += 1 }
        if Int(pcosResponses[4]) ?? 0 > 1 { score += 1 }
        if pcosResponses[5].lowercased().contains("yes") { score += 2 }
        if pcosResponses[6].lowercased().contains("yes") { score += 2 }
        if pcosResponses[7].lowercased().contains("high") { score += 1 }
        if Int(pcosResponses[8]) ?? 0 < 4 { score += 1 }

        return score
    }

    private func getPcosRiskMessage(for score: Int) -> String {
        switch score {
        case 8...:
            return "Your responses suggest a higher likelihood of PCOS. Consider consulting a doctor for professional guidance."
        case 5...7:
            return "You show some signs linked to PCOS. It may be helpful to track your symptoms and maintain a healthy lifestyle."
        default:
            return "Your responses don’t strongly indicate PCOS. If you have concerns, a doctor’s advice is always recommended."
        }
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

