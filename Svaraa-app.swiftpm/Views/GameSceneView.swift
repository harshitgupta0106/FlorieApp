//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 13/02/25.
//

import SwiftUI

struct GameSceneView: View {
    var body: some View {
        ZStack {
            VStack(spacing: -300) {
                Image("Svaraa_Happy")
                    .resizable()
                    .scaledToFit()
                GradientView()
            }
            
            VStack(spacing: 20) {
                Spacer()
                Spacer()
                Text("Wanna get into the game?")
                    .font(.title)
                    .foregroundStyle(.white)
                    .shadow(radius: 20)
                Button("Let's start") {
                    
                }
                .padding([.leading, .trailing], 30.0)
                .padding([.top, .bottom], 10.0)
                .foregroundStyle(Color.black)
                .background(Color.yellow)
                .cornerRadius(12)
                Spacer()
            }
            
        }
    }
}

struct GradientView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.purple.opacity(0.8), // Fully black at the bottom
                    Color.purple.opacity(0.7),
                    Color.purple.opacity(0)  // Fully transparent at the top
                ]),
                startPoint: .bottom,
                endPoint: .top
            ) // Adjust height as needed
        } // Extend gradient to edges if necessary
    }
}

#Preview {
    GameSceneView()
}
