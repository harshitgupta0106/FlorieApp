//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 15/02/25.
//

import SwiftUI
struct OnboardingView: View {
    @State private var inputText: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardingGradientView()
                VStack/*(spacing: 60)*/ {
                    Spacer()
                        VStack(spacing: 5) {
                            Text("Enter your name")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                            Image("Heart_3D")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                    Spacer()
                    TextField("Enter your beautiful name", text: $inputText)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .foregroundColor(.primary)
                        .font(.title2)
                        .padding([.leading, .trailing], 50)
                        .textFieldStyle(PlainTextFieldStyle()) // Removes default border
                        .onSubmit {
                            DataController.shared.setUserName(name: inputText)
                        }

                    Spacer()
                        VStack(spacing: 10) {
                                NavigationLink(destination: AgeFormView().onAppear {
                                    DataController.shared.setUserName(name: inputText)
                                }) {
                                    Text("Continue")
                                }
                                .disabled(inputText.isEmpty)
                                .font(.title2)
                                .buttonStyle(.borderedProminent)
                                .padding()
                                NavigationLink(destination: MainTabView()) {
                                    Text("Skip")
                                }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AgeFormView: View {
    @State var age: Int = 10
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardingGradientView()
                VStack(spacing: 10) {
                    Spacer()
                    Text("Enter your age")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Spacer()
                    HStack {
                        Button("", systemImage: "minus.circle.fill") {
                            if age > 1 {
                                age -= 1
                            }
                        }
                        .font(.system(size: 50))
                        //                    .imageScale(.small)
                        .background(Color.clear)
                        Spacer()
                        Text("\(age)")
                            .font(.largeTitle)
                            .padding(10)
                        Spacer()
                        Button("", systemImage: "plus.circle.fill") {
                            if age < 100 {
                                age += 1
                            }
                        }
                        .font(.system(size: 50))
                        .background(Color.clear)
                    }
                    .padding(70)
                    NavigationLink(destination: MainTabView().onAppear {
                        DataController.shared.setUserAge(age: age)
                        print(DataController.shared.getUserAge())
                    }) {
                        Text("Continue")
                    }
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .padding()
                    Spacer()
                    Spacer()
                }
            }
            .ignoresSafeArea()
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
