import SwiftUI

struct SvaraaTalkView: View {
    @State private var messages: [Message] = []
    @State var isConversing: Bool = false
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var isShowingQuestionSelector = false
    
    var body: some View {
        ZStack {
            GradientChatBot(isConversing: $isConversing)
            VStack {
                Spacer()
                HStack(alignment: .top, spacing: 60) {
                    Button(action: {
                        messages.removeAll()
                        isShowingQuestionSelector = false
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
                    InitialView(isConversing: $isConversing, messages: $messages/*, isPcodTest: $isPcodTest, pcodQuestionIndex: $pcodQuestionIndex, isPcosTest: $isPcosTest, pcosQuestionIndex: $pcosQuestionIndex*/)
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
                
                Button(action: {
                        isShowingQuestionSelector = true
                    }
                ) {
                    Label("Ask a question", systemImage: "plus")
                            .frame(maxWidth: .infinity)
                    }
                .buttonStyle(.automatic)
                .padding(.vertical, 20)
            }
            .sheet(isPresented: $isShowingQuestionSelector) {
                NavigationStack {
                    QuestionCategorySelectionView(isShowingQuestionSelector: $isShowingQuestionSelector, isConversing: $isConversing) { selectedQA in
                        messages.append(Message(text: selectedQA.question, isUser: true))
                        messages.append(Message(text: selectedQA.answer, isUser: false))
                    }
                }
                .presentationDetents([.medium, .large])
            }
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

