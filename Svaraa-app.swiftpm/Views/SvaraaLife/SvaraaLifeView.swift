import SwiftUI

struct SvaraaLifeView: View {
    @State private var currentStoryIndex: Int = -1
    @State private var currentSceneIndex: Int = 0
    @State private var currentSceneTextIndex: Int = 0
    @State var showMCQScene: Bool = false
    @State var showFinalScene: Bool = false
    @State private var moveToCenter = false
    @State private var moveToLeft = false

    var body: some View {
        ZStack {
            if showFinalScene && currentStoryIndex >= 0 {
                FinalSceneView(
                    text: DataController.shared.getFinalScene(ofStoryIndex: currentStoryIndex).descriptions[0]
                )
                .onTapGesture {
                    showFinalScene = false
                    moveToNextStory()
                }
            } else if showMCQScene && currentStoryIndex >= 0 {
                let story = DataController.shared.getStory(at: currentStoryIndex)
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
                    GeometryReader { geometry in
                        NewStoryGradientView()
                            .position(x: moveToLeft ? -200 : (moveToCenter ? geometry.size.width / 2 : geometry.size.width + 100),
                                      y: geometry.size.height / 2)
                            .onAppear { restartAnimation(geometry: geometry) }
                            .onChange(of: currentStoryIndex) { restartAnimation(geometry: geometry) }
                    }
                }
            }
        }
    }
    
    private func restartAnimation(geometry: GeometryProxy) {
        moveToCenter = false
        moveToLeft = false

        withAnimation(.bouncy(duration: 1)) {
            moveToCenter = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Delay for smooth transition
                withAnimation(.bouncy(duration: 1)) {
                    moveToLeft = true
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
            showMCQScene = true
        }
    }
    
    private func moveToNextStory() {
        let totalStories = DataController.shared.getNumberOfStories()

        if currentStoryIndex < totalStories - 1 {
            currentStoryIndex += 1
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            showMCQScene = false
            showFinalScene = false
        } else {
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
