//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 13/02/25.
//

import SwiftUI

struct InitalStorySceneView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("Svaraa_Happy")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            
        GradientView()
            VStack(spacing: 20) {
                Spacer()
                Spacer()
                Text("Tap to start the game!")
                    .font(.title)
                    .foregroundStyle(.white)
                    .shadow(radius: 20)
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
                    Color.purple.opacity(0.8),
                    Color.purple.opacity(0.7),
                    Color.purple.opacity(0.3),
                    Color.purple.opacity(0.1),
                    Color.purple.opacity(0),
                ]),
                startPoint: .bottom,
                endPoint: .top
            ) 
        }
        
    }
}

#Preview {
    InitalStorySceneView()
}
