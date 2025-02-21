//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 20/02/25.
//

import SwiftUI

struct MenuView: View {
    @Binding var currentStoryIndex: Int
    @Binding var currentSceneIndex: Int
    @Binding var currentSceneTextIndex: Int
    @Binding var showMCQScene: Bool
    @Binding var showFinalScene: Bool
    @Binding var menuOpened: Bool
    @AppStorage("currentStoryIndex") private var storedStoryIndex: Int = -1
    private let allStories = DataController.shared.getAllStories()

    var body: some View {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        VStack {
            List {
                ForEach(allStories.indices, id: \.self) { index in
                    let imageName = allStories[index].storyImage
                    let title = allStories[index].title
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Image("Svaraa_Tick")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .opacity(index > currentStoryIndex - 1 ? 0 : 1)
                            Spacer()
                            Text(title)
                            Spacer()
                        }
                        .padding(10)
                        Spacer()
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .padding()
                    }
                    .listRowBackground(Color.clear)
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(width: 360,height: 170)
                    .listRowSeparator(.hidden)
                    .background(Color.accentColor.opacity(0.8))
                    .cornerRadius(15)
                    .onTapGesture {
                        generator.impactOccurred()
                        handleStorySelection(index: index)
                    }
                    .contentShape(Rectangle())
                }
            }
        }
    }
    private func handleStorySelection(index: Int) {
        print("Tapped on story \(index)")
        
        DispatchQueue.main.async {
            menuOpened = false
            print("menuOpened set to false")
            
            currentStoryIndex = index
            storedStoryIndex = index
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            showMCQScene = false
            showFinalScene = false
        }
    }


}

