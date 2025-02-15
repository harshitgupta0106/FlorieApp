//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 15/02/25.
//

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
                    Spacer()
                        VStack(spacing: 20) {
                            Text("Enter your name")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .shadow(color: .accentColor, radius: 25)
                            Image("Svaraa_Onboarding")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300)
                                .shadow(color: .purple, radius: 170)
                        }
                    Spacer()
                    TextField("Enter your beautiful name", text: $inputText)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .foregroundColor(.primary)
                        .font(.title2)
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
                                        .frame(maxWidth: .infinity)
                                        .frame(maxHeight: 12)
                                        .padding()
                                        .background(inputText.isEmpty ? Color.gray : Color.accentColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                }
                                .font(.title2)
                                .padding(.horizontal, 50)
                                .disabled(inputText.isEmpty)
                            NavigationLink(destination: MainTabView().onAppear {
                                generator.impactOccurred()
                            }) {
                                    Text("Skip")
                                }
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
                        .shadow(color: .accentColor, radius: 35)
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
                        Text("\(age)")
                            .font(.largeTitle)
                            .padding(10)
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
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: 12)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .font(.title2)
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
