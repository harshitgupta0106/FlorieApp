//import SwiftUI
//
//struct SvaraaLifeView: View {
//    @State private var currentStoryIndex: Int = -1
//    @State private var currentSceneIndex: Int = 0
//    @State private var currentSceneTextIndex: Int = 0
//    @State private var showMCQScene: Bool = false
//    @State private var showFinalScene: Bool = false
//
//    var body: some View {
//        ZStack {
//            if showFinalScene {
//                if currentStoryIndex >= 0 {
//                    FinalSceneView(
//                        text: DataController.shared.getFinalScene(ofStoryIndex: currentStoryIndex).descriptions[0]
//                    )
//                    .onTapGesture {
//                        showFinalScene = false  // Reset before moving to next story
//                        moveToNextStory()
//                    }
//                }
//
//                
//            } else if showMCQScene {
//                let story = DataController.shared.getStory(at: currentStoryIndex)
//                MCQSceneView(
//                    question: story.mcqScene.question,
//                    options: story.mcqScene.options,
//                    correctOptionIndex: story.mcqScene.correctOptionIndex,
//                    showMCQScene: $showMCQScene,
//                    showFinalScene: $showFinalScene
//                )
//            } else {
//                VStack {
//                    if currentStoryIndex == -1 {
//                        InitalStorySceneView()
//                    } else if currentStoryIndex < DataController.shared.getNumberOfStories() {
//                        let story = DataController.shared.getStory(at: currentStoryIndex)
//                        StorySceneView(
//                            svaraaImage: story.storyScenes[currentSceneIndex].svaraaImageName,
//                            storyTitle: story.title,
//                            description: story.storyScenes[currentSceneIndex].descriptions[currentSceneTextIndex]
//                        )
//                    }
//                }
//                .onTapGesture {
//                    progressStory()
//                }
//
//                if currentStoryIndex > -1 && currentSceneIndex == 0 && currentSceneTextIndex == 0 {
//                    VStack {
//                        Text(DataController.shared.getTitleOfStory(ofStoryIndex: currentStoryIndex))
//                            .font(.title3)
//                            .bold()
//                            .italic()
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(Color.indigo.opacity(0.8))
//                            .cornerRadius(12)
//                            .frame(width: 350)
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
//
//    private func progressStory() {
//        let generator = UIImpactFeedbackGenerator(style: .light)
//        generator.impactOccurred()
//
//        let totalStories = DataController.shared.getNumberOfStories()
//
//        if currentStoryIndex == -1 {
//            if totalStories > 0 {
//                // Start the first story only if there are stories available
//                currentStoryIndex = 0
//                currentSceneIndex = 0
//                currentSceneTextIndex = 0
//                showMCQScene = false
//                showFinalScene = false
//            }
//            return
//        }
//
//        guard currentStoryIndex < totalStories else {
//            print("Error: Attempted to access an out-of-bounds story index.")
//            return
//        }
//
//        let totalScenes = DataController.shared.getNumberOfStoryScenes(ofStoryIndex: currentStoryIndex)
//        let totalTexts = DataController.shared.getNumberOfDescriptionsInScene(ofStoryIndex: currentStoryIndex, sceneIndex: currentSceneIndex)
//
//        if currentSceneTextIndex < totalTexts - 1 {
//            currentSceneTextIndex += 1
//        } else if currentSceneIndex < totalScenes - 1 {
//            currentSceneIndex += 1
//            currentSceneTextIndex = 0
//        } else {
//            showMCQScene = true
//        }
//    }
//
//
//
//    private func moveToNextStory() {
//        let totalStories = DataController.shared.getNumberOfStories()
//
//        if currentStoryIndex < totalStories - 1 {
//            // Move to the next story
//            currentStoryIndex += 1
//        } else {
//            // Instead of resetting immediately, delay reset after initial scene tap
//            currentSceneIndex = 0
//            currentSceneTextIndex = 0
//            showMCQScene = false
//            showFinalScene = false
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                currentStoryIndex = -1
//            }
//        }
//    }
//
//}
//
//#Preview {
//    SvaraaLifeView()
//}
//
//import SwiftUI
//
//struct SvaraaLifeView: View {
//    @State private var currentStoryIndex: Int = -1
//    @State private var currentSceneIndex: Int = 0
//    @State private var currentSceneTextIndex: Int = 0
//    @State private var showMCQScene: Bool = false
//    @State private var showFinalScene: Bool = false
//
//    var body: some View {
//        ZStack {
//            if showFinalScene && currentStoryIndex >= 0 {
//                FinalSceneView(
//                    text: DataController.shared.getFinalScene(ofStoryIndex: currentStoryIndex).descriptions[0]
//                )
//                .onTapGesture {
//                    showFinalScene = false  // Reset before moving to next story
//                    moveToNextStory()
//                }
//            } else if showMCQScene && currentStoryIndex >= 0 {
//                let story = DataController.shared.getStory(at: currentStoryIndex)
//                MCQSceneView(
//                    question: story.mcqScene.question,
//                    options: story.mcqScene.options,
//                    correctOptionIndex: story.mcqScene.correctOptionIndex,
//                    showMCQScene: $showMCQScene,
//                    showFinalScene: $showFinalScene
//                )
//            } else {
//                VStack {
//                    if currentStoryIndex == -1 {
//                        InitalStorySceneView()
//                    } else if currentStoryIndex < DataController.shared.getNumberOfStories() {
//                        let story = DataController.shared.getStory(at: currentStoryIndex)
//                        StorySceneView(
//                            svaraaImage: story.storyScenes[currentSceneIndex].svaraaImageName,
//                            storyTitle: story.title,
//                            description: story.storyScenes[currentSceneIndex].descriptions[currentSceneTextIndex]
//                        )
//                    }
//                }
//                .onTapGesture {
//                    progressStory()
//                }
//
//                if currentStoryIndex > -1 && currentSceneIndex == 0 && currentSceneTextIndex == 0 {
//                    VStack {
//                        Text(DataController.shared.getTitleOfStory(ofStoryIndex: currentStoryIndex))
//                            .font(.title3)
//                            .bold()
//                            .italic()
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(Color.indigo.opacity(0.8))
//                            .cornerRadius(12)
//                            .frame(width: 350)
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
//
//    private func progressStory() {
//        let generator = UIImpactFeedbackGenerator(style: .light)
//        generator.impactOccurred()
//
//        let totalStories = DataController.shared.getNumberOfStories()
//
//        if currentStoryIndex == -1 {
//            if totalStories > 0 {
//                // Start the first story only if there are stories available
//                currentStoryIndex = 0
//                currentSceneIndex = 0
//                currentSceneTextIndex = 0
//                showMCQScene = false
//                showFinalScene = false
//            }
//            return
//        }
//
//        guard currentStoryIndex < totalStories else {
//            print("Error: Attempted to access an out-of-bounds story index.")
//            return
//        }
//
//        let totalScenes = DataController.shared.getNumberOfStoryScenes(ofStoryIndex: currentStoryIndex)
//        let totalTexts = DataController.shared.getNumberOfDescriptionsInScene(ofStoryIndex: currentStoryIndex, sceneIndex: currentSceneIndex)
//
//        if currentSceneTextIndex < totalTexts - 1 {
//            currentSceneTextIndex += 1
//        } else if currentSceneIndex < totalScenes - 1 {
//            currentSceneIndex += 1
//            currentSceneTextIndex = 0
//        } else {
//            showMCQScene = true
//        }
//    }
//
//    private func moveToNextStory() {
//        let totalStories = DataController.shared.getNumberOfStories()
//
//        if currentStoryIndex < totalStories - 1 {
//            // Move to the next story
//            currentStoryIndex += 1
//            currentSceneIndex = 0
//            currentSceneTextIndex = 0
//            showMCQScene = false
//            showFinalScene = false
//        } else {
//            // Reset to the initial story scene
//            currentStoryIndex = -1
//            currentSceneIndex = 0
//            currentSceneTextIndex = 0
//            showMCQScene = false
//            showFinalScene = false
//        }
//    }
//}
//
//#Preview {
//    SvaraaLifeView()
//}

import SwiftUI

struct SvaraaLifeView: View {
    @State private var currentStoryIndex: Int = -1
    @State private var currentSceneIndex: Int = 0
    @State private var currentSceneTextIndex: Int = 0
    @State var showMCQScene: Bool = false
    @State var showFinalScene: Bool = false

    var body: some View {
        ZStack {
            if showFinalScene && currentStoryIndex >= 0 {
                FinalSceneView(
                    text: DataController.shared.getFinalScene(ofStoryIndex: currentStoryIndex).descriptions[0]
                )
                .onTapGesture {
                    showFinalScene = false  // Reset before moving to next story
                    moveToNextStory()
                }
            } else if showMCQScene && currentStoryIndex >= 0 {
                let story = DataController.shared.getStory(at: currentStoryIndex)
                
//                MCQSceneView(question: story.mcqScene.question,options: story.mcqScene.options, correctOptionIndex: story.mcqScene.correctOptionIndex, showMCQScene: <#T##Bool#>, showFinalScene: <#T##Bool#>, showResult: <#T##Bool#>)
                MCQSceneView(
                    question: story.mcqScene.question,
                    options: story.mcqScene.options,
                    correctOptionIndex: story.mcqScene.correctOptionIndex,
                    showMCQScene: $showMCQScene,
                    showFinalScene: $showFinalScene
                )
            } else {
                VStack {
                    if currentStoryIndex == -1 {
                        InitalStorySceneView()
                    } else if currentStoryIndex < DataController.shared.getNumberOfStories() {
                        let story = DataController.shared.getStory(at: currentStoryIndex)
                        StorySceneView(
                            svaraaImage: story.storyScenes[currentSceneIndex].svaraaImageName,
                            storyTitle: story.title,
                            description: story.storyScenes[currentSceneIndex].descriptions[currentSceneTextIndex]
                        )
                    }
                }
                .onTapGesture {
                    progressStory()
                }

                if currentStoryIndex > -1 && currentSceneIndex == 0 && currentSceneTextIndex == 0 {
                    VStack {
                        Text(DataController.shared.getTitleOfStory(ofStoryIndex: currentStoryIndex))
                            .font(.title3)
                            .bold()
                            .italic()
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.indigo.opacity(0.8))
                            .cornerRadius(12)
                            .frame(width: 350)
                        Spacer()
                    }
                }
            }
        }
    }

    private func progressStory() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        let totalStories = DataController.shared.getNumberOfStories()

        if currentStoryIndex == -1 {
            if totalStories > 0 {
                // Start the first story only if there are stories available
                currentStoryIndex = 0
                currentSceneIndex = 0
                currentSceneTextIndex = 0
                showMCQScene = false
                showFinalScene = false
            }
            return
        }

        guard currentStoryIndex < totalStories else {
            print("Error: Attempted to access an out-of-bounds story index.")
            return
        }

        let totalScenes = DataController.shared.getNumberOfStoryScenes(ofStoryIndex: currentStoryIndex)
        let totalTexts = DataController.shared.getNumberOfDescriptionsInScene(ofStoryIndex: currentStoryIndex, sceneIndex: currentSceneIndex)

        if currentSceneTextIndex < totalTexts - 1 {
            currentSceneTextIndex += 1
        } else if currentSceneIndex < totalScenes - 1 {
            currentSceneIndex += 1
            currentSceneTextIndex = 0
        } else {
            // Only show MCQ scene if there are no more scenes or texts
            showMCQScene = true
        }
    }
    private func moveToNextStory() {
        let totalStories = DataController.shared.getNumberOfStories()

        if currentStoryIndex < totalStories - 1 {
            // Move to the next story
            currentStoryIndex += 1
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            showMCQScene = false
            showFinalScene = false
        } else {
            // Reset to the initial story scene
            currentStoryIndex = -1
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            showMCQScene = false
            showFinalScene = false
        }
    }
}

#Preview {
    SvaraaLifeView()
}
