
import SwiftUI
struct OnboardingView: View {
    @State private var inputText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        let generator = UIImpactFeedbackGenerator(style: .light)
        NavigationStack {
            ZStack {
                OnboardingGradientView()
                VStack(spacing: 30) {
                    HStack {
                        Spacer()
                        NavigationLink(destination: MainTabView().onAppear {
                            generator.impactOccurred()
                        }) {
                                Text("Skip")
                            }
                    }
                    .padding([.top, .trailing])
                    Spacer()
                        VStack(spacing: 20) {
                            Text("Enter your name")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .shadow(color: .accentColor, radius: 20)
                            Image("Svaraa_Onboarding")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300)
                                .shadow(color: .accentColor, radius: 100)
                        }
                    Spacer()
                    TextField("Enter your beautiful name", text: $inputText)
                        .frame(maxHeight: 12)
                        .padding()
                        .foregroundColor(.primary)
                        .font(.title2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.primary, lineWidth: 0.3)
                        )
                        .padding([.leading, .trailing], 50)
                        .textFieldStyle(PlainTextFieldStyle())
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            DataController.shared.setUserName(name: inputText)
                        }
                        VStack(spacing: 10) {
                                NavigationLink(destination: AgeFormView().onAppear {
                                    DataController.shared.setUserName(name: inputText)
                                    generator.impactOccurred()
                                }) {
                                    Text("Continue")
                                        .frame(maxHeight: 12)
                                        .padding()
                                        .background(Color.accentColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                                .padding(.horizontal, 50)
                                .disabled(inputText.isEmpty)
                    }
                    Spacer()
                }
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
        }
    }
}

struct AgeFormView: View {
    @State var age: Int = 10
    let generator = UIImpactFeedbackGenerator(style: .light)
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardingGradientView()
                VStack(spacing: 10) {
                    Spacer()
                    Text("Enter your age")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 25)
                    Spacer()
                    HStack {
                        Button("", systemImage: "minus.circle.fill") {
                            generator.impactOccurred()
                            if age > 1 {
                                age -= 1
                            }
                        }
                        .font(.system(size: 50))
                        .background(Color.clear)
                        Spacer()
                        VStack {
                            Text("\(age)")
                                .font(.largeTitle)
                                .padding([.horizontal], 10)
                            Text("YEARS")
                        }
                        Spacer()
                        Button("", systemImage: "plus.circle.fill") {
                            generator.impactOccurred()
                            if age < 100 {
                                age += 1
                            }
                        }
                        .font(.system(size: 50))
                        .background(Color.clear)
                    }
                    .padding(70)
                    NavigationLink(destination: MainTabView().onAppear {
                        generator.impactOccurred()
                        DataController.shared.setUserAge(age: age)
                    }) {
                        Text("Continue")
                            .frame(maxHeight: 12)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 50)

                    Spacer()
                    Spacer()
                }
            }
        }
    }
}

struct OnboardingGradientView: View {
    var body: some View {
        let color = Color.purple
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
        .animation(.easeInOut(duration: 1), value: true)
    }
}

#Preview {
    OnboardingView()
}
