//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 15/02/25.
//

import SwiftUI

//struct FinalSceneView: View {
//
//    var text: String?
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Image("Svaraa_Satisfied")
//                    .resizable()
//                    .scaledToFit()
//                Spacer()
//            }
//
//            GradientView()
//            VStack(alignment: .center, spacing: 30) {
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
//                if let text {
//                    Text(text)
//                        .font(.body)
//                        .padding()
//                        .foregroundStyle(.white)
//                        .background(Color.indigo.opacity(0.7))
//                        .cornerRadius(12)
//                        .padding()
//                }
//
//                Text("Tap to continue")
//                    .foregroundStyle(.white)
//            }
//            .padding(.bottom, 20.0)
//
//        }
//
////        showFinalScene = false
//    }
//}

struct FinalSceneView: View {
    var text: String?
    
    var body: some View {
        ZStack {
            VStack {
                Image("Svaraa_Satisfied")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            
            GradientView()
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                if let text {
                    Text(text)
                        .font(.body)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.indigo.opacity(0.7))
                        .cornerRadius(12)
                        .padding()
                }
                
                Text("Tap to continue")
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 20.0)
        }
    }
}

#Preview {
    FinalSceneView()
}
