import SwiftUI

struct SvaraaLifeView: View {
    @State private var currentStoryIndex: Int = -1
    @State private var currentSceneIndex: Int = 0
    @State private var currentSceneTextIndex: Int = 0
    @State private var showMCQScene: Bool = false
    @State private var showFinalScene: Bool = false

    var body: some View {
        ZStack {
            if showMCQScene {
                MCQSceneView(
                    question: "What should Svaraa do next?",
                    options: [
                        "Panic and hide it from everyone.",
                        "Use tissue paper and hope it stops.",
                        "Find an elder she trusts and ask for help.",
                        "Ignore it and continue with the party."
                    ],
                    correctOptionIndex: 2
                )
            }
            else {
                VStack {
                    if currentStoryIndex == -1 {
                        InitalStorySceneView()
                    } else {
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
        if currentStoryIndex == -1 {
            // Start the first story
            currentStoryIndex = 0
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            return
        }

        let totalStories = DataController.shared.getNumberOfStories()
        let totalScenes = DataController.shared.getNumberOfStoryScenes(ofStoryIndex: currentStoryIndex)
        let totalTexts = DataController.shared.getNumberOfDescriptionsInScene(ofStoryIndex: currentStoryIndex, sceneIndex: currentSceneIndex)

        if currentSceneTextIndex < totalTexts - 1 {
            // Move to next text in the scene
            currentSceneTextIndex += 1
        } else if currentSceneIndex < totalScenes - 1 {
            // Move to next scene
            currentSceneIndex += 1
            currentSceneTextIndex = 0
        } else if currentStoryIndex < totalStories - 1 {
            // Move to next story
            currentStoryIndex += 1
            currentSceneIndex = 0
            currentSceneTextIndex = 0
        } else {
            // Last scene completed -> Move to MCQ Scene
            showMCQScene = true
        }
    }
}


#Preview {
    SvaraaLifeView()
}
