//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 14/02/25.
//

import SwiftUI

struct StorySceneView: View {
    var svaraaImage: String?
    var storyTitle: String?
    var description: String?
    
    var body: some View {
        ZStack {
            VStack {
                Image(svaraaImage ?? "Svaraa_VeryHappy")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            
            GradientView()
            VStack(alignment: .center, spacing: 100) {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Text(description ?? "She remembers a health class where they mentioned something about periods.")
                    .font(.body)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.indigo.opacity(0.7))
                    .cornerRadius(12)
                    .padding()
                
                Text("Tap to continue")
                    .foregroundStyle(.white)
//                    .shadow(radius: 70)
            }
            .padding(.bottom, 20.0)
            
        }
    }
}


#Preview {
    StorySceneView()
}
