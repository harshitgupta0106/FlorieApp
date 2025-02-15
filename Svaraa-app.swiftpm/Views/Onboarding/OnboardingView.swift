//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 15/02/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            
        }
    }
}

struct NameFormView: View {
    var body: some View {
        ZStack {
            
        }
    }
}

struct AgeFormView: View {
    @State var age: Int = 10
    var body: some View {
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
                Button("Continue") {
                    DataController.shared.setUserAge(age: age)
//                    NavigationLink(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, destination: <#T##() -> View#>)
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
    AgeFormView()
}
