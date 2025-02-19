//import SwiftUI
//
//struct SvaraaLifeView: View {
//    @State var currentStoryIndex: Int? = UserDefaults.standard.integer(forKey: "currentStoryIndex")
//    @State var currentSceneIndex: Int = 0
//    @State var currentSceneTextIndex: Int = 0
//    @State var showMCQScene: Bool = false
//    @State var showFinalScene: Bool = false
//    @State private var moveToCenter = false
//    @State private var moveToLeft = false
//    @State var menuOpened: Bool = false
//    var body: some View {
//        if let currentStoryIndex {
//            ZStack {
//                if showFinalScene && currentStoryIndex >= 0 {
//                    FinalSceneView(
//                        text: DataController.shared.getFinalScene(ofStoryIndex: currentStoryIndex).descriptions[0]
//                    )
//                    .onTapGesture {
//                        showFinalScene = false
//                        moveToNextStory()
//                    }
//                } else if showMCQScene && currentStoryIndex >= 0 {
//                    let story = DataController.shared.getStory(at: currentStoryIndex)
//                    MCQSceneView(
//                        question: story.mcqScene.question,
//                        options: story.mcqScene.options,
//                        correctOptionIndex: story.mcqScene.correctOptionIndex,
//                        showMCQScene: $showMCQScene,
//                        showFinalScene: $showFinalScene
//                    )
//                } else {
//                    VStack {
//                        if currentStoryIndex == -1 {
//                            InitalStorySceneView()
//                        } else if currentStoryIndex < DataController.shared.getNumberOfStories() {
//                            let story = DataController.shared.getStory(at: currentStoryIndex)
//                            StorySceneView(
//                                svaraaImage: story.storyScenes[currentSceneIndex].svaraaImageName,
//                                storyTitle: story.title,
//                                description: story.storyScenes[currentSceneIndex].descriptions[currentSceneTextIndex]
//                            )
//                        }
//                    }
//                    .onTapGesture {
//                        progressStory()
//                    }
//                    
//                    if currentStoryIndex > -1 && currentSceneIndex == 0 && currentSceneTextIndex == 0 {
//                        VStack {
//                            Text(DataController.shared.getTitleOfStory(ofStoryIndex: currentStoryIndex))
//                                .font(.title3)
//                                .bold()
//                                .italic()
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.indigo.opacity(0.8))
//                                .cornerRadius(12)
//                                .frame(width: 300)
////                                .padding([.leading, .trailing], 25)
//                            Spacer()
//                        }
//                        GeometryReader { geometry in
//                            NewStoryGradientView()
//                                .position(x: moveToLeft ? -200 : (moveToCenter ? geometry.size.width / 2 : geometry.size.width + 100),
//                                          y: geometry.size.height / 2)
//                                .onAppear { restartAnimation(geometry: geometry) }
//                                .onChange(of: currentStoryIndex) { restartAnimation(geometry: geometry) }
//                        }
//                    }
//                    
//                    if menuOpened {
//                        MenuView(currentStoryIndex: $currentStoryIndex, currentSceneIndex: $currentSceneIndex, currentSceneTextIndex: $currentSceneTextIndex, showMCQScene: $showMCQScene, showFinalScene: $showFinalScene, menuOpened: $menuOpened)
//                    }
//                    
//                    VStack {
//                        HStack(alignment: .top) {
//                            Button("", systemImage: "list.dash") {
//                                menuOpened.toggle()
//                            }
//                            .imageScale(.large)
//                            
//                            .buttonStyle(.automatic)
//                            .padding()
//                            Spacer()
//                        }
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    
//    private func restartAnimation(geometry: GeometryProxy) {
//        moveToCenter = false
//        moveToLeft = false
//
//        withAnimation(.bouncy(duration: 1)) {
//            moveToCenter = true
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Delay for smooth transition
//                withAnimation(.bouncy(duration: 1)) {
//                    moveToLeft = true
//                }
//            }
//        }
//    }
//
//
//
//
//    private func progressStory() {
//        let generator = UIImpactFeedbackGenerator(style: .light)
//        generator.impactOccurred()
//
//        let totalStories = DataController.shared.getNumberOfStories()
//
//        if currentStoryIndex == -1 {
//            if totalStories > 0 {
//                currentStoryIndex = 0
//                currentSceneIndex = 0
//                currentSceneTextIndex = 0
//                showMCQScene = false
//                showFinalScene = false
//            }
//            return
//        }
//
//        guard let currentStoryIndex, currentStoryIndex < totalStories else {
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
//        if currentStoryIndex != nil {
//            if currentStoryIndex! < totalStories - 1 {
//                currentStoryIndex! += 1
//                currentSceneIndex = 0
//                currentSceneTextIndex = 0
//                showMCQScene = false
//                showFinalScene = false
//            } else {
//                currentStoryIndex = -1
//                currentSceneIndex = 0
//                currentSceneTextIndex = 0
//                showMCQScene = false
//                showFinalScene = false
//            }
//        }
//    }
//    
//    private func saveCurrentStoryIndex() {
//        if let index = currentStoryIndex {
//            UserDefaults.standard.set(index, forKey: "currentStoryIndex")
//        }
//    }
//}
//
//import SwiftUI
//
//struct SvaraaLifeView: View {
////    @AppStorage("currentStoryIndex") private var storedStoryIndex: Int = -1
//    @AppStorage("currentStoryIndex") private var currentStoryIndex: Int = -1
//    @State var currentStoryIndex: Int? = -1
//    @State var currentSceneIndex: Int = 0
//    @State var currentSceneTextIndex: Int = 0
//    @State var showMCQScene: Bool = false
//    @State var showFinalScene: Bool = false
//    @State private var moveToCenter = false
//    @State private var moveToLeft = false
//    @State var menuOpened: Bool = false
//    
//    var body: some View {
//        if let currentStoryIndex {
//            ZStack {
//                if showFinalScene && currentStoryIndex >= 0 {
//                    FinalSceneView(
//                        text: DataController.shared.getFinalScene(ofStoryIndex: currentStoryIndex).descriptions[0]
//                    )
//                    .onTapGesture {
//                        showFinalScene = false
//                        moveToNextStory()
//                    }
//                } else if showMCQScene && currentStoryIndex >= 0 {
//                    let story = DataController.shared.getStory(at: currentStoryIndex)
//                    MCQSceneView(
//                        question: story.mcqScene.question,
//                        options: story.mcqScene.options,
//                        correctOptionIndex: story.mcqScene.correctOptionIndex,
//                        showMCQScene: $showMCQScene,
//                        showFinalScene: $showFinalScene
//                    )
//                } else {
//                    VStack {
//                        if currentStoryIndex == -1 {
//                            InitalStorySceneView()
//                        } else if currentStoryIndex < DataController.shared.getNumberOfStories() {
//                            let story = DataController.shared.getStory(at: currentStoryIndex)
//                            StorySceneView(
//                                svaraaImage: story.storyScenes[currentSceneIndex].svaraaImageName,
//                                storyTitle: story.title,
//                                description: story.storyScenes[currentSceneIndex].descriptions[currentSceneTextIndex]
//                            )
//                        }
//                    }
//                    .onTapGesture {
//                        startOrProgressStory()
//                    }
//                    
//                    if currentStoryIndex > -1 && currentSceneIndex == 0 && currentSceneTextIndex == 0 {
//                        VStack {
//                            Text(DataController.shared.getTitleOfStory(ofStoryIndex: currentStoryIndex))
//                                .font(.title3)
//                                .bold()
//                                .italic()
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.indigo.opacity(0.8))
//                                .cornerRadius(12)
//                                .frame(width: 300)
//                            Spacer()
//                        }
//                        GeometryReader { geometry in
//                            NewStoryGradientView()
//                                .position(x: moveToLeft ? -200 : (moveToCenter ? geometry.size.width / 2 : geometry.size.width + 100),
//                                          y: geometry.size.height / 2)
//                                .onAppear { restartAnimation(geometry: geometry) }
//                                .onChange(of: currentStoryIndex) { restartAnimation(geometry: geometry) }
//                        }
//                    }
//                    
//                    if menuOpened {
//                        MenuView(currentStoryIndex: $currentStoryIndex, currentSceneIndex: $currentSceneIndex, currentSceneTextIndex: $currentSceneTextIndex, showMCQScene: $showMCQScene, showFinalScene: $showFinalScene, menuOpened: $menuOpened)
//                    }
//                    
//                    VStack {
//                        HStack(alignment: .top) {
//                            Button("", systemImage: "list.dash") {
//                                menuOpened.toggle()
//                            }
//                            .imageScale(.large)
//                            .buttonStyle(.automatic)
//                            .padding()
//                            Spacer()
//                        }
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    
//    private func restartAnimation(geometry: GeometryProxy) {
//        moveToCenter = false
//        moveToLeft = false
//
//        withAnimation(.bouncy(duration: 1)) {
//            moveToCenter = true
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Delay for smooth transition
//                withAnimation(.bouncy(duration: 1)) {
//                    moveToLeft = true
//                }
//            }
//        }
//    }
//
//
//
//
//    private func startOrProgressStory() {
//            if currentStoryIndex == -1 {
//                // Load from local storage on first tap
//                currentStoryIndex = storedStoryIndex != -1 ? storedStoryIndex : 0
//                currentSceneIndex = 0
//                currentSceneTextIndex = 0
//                showMCQScene = false
//                showFinalScene = false
//            } else {
//                progressStory()
//            }
//        }
//
//        private func progressStory() {
//            let generator = UIImpactFeedbackGenerator(style: .light)
//            generator.impactOccurred()
//
//            let totalStories = DataController.shared.getNumberOfStories()
//
//            guard let currentStoryIndex, currentStoryIndex < totalStories else {
//                print("Error: Attempted to access an out-of-bounds story index.")
//                return
//            }
//
//            let totalScenes = DataController.shared.getNumberOfStoryScenes(ofStoryIndex: currentStoryIndex)
//            let totalTexts = DataController.shared.getNumberOfDescriptionsInScene(ofStoryIndex: currentStoryIndex, sceneIndex: currentSceneIndex)
//
//            if currentSceneTextIndex < totalTexts - 1 {
//                currentSceneTextIndex += 1
//            } else if currentSceneIndex < totalScenes - 1 {
//                currentSceneIndex += 1
//                currentSceneTextIndex = 0
//            } else {
//                showMCQScene = true
//            }
//            
//            // Save current story index to local storage
//            storedStoryIndex = currentStoryIndex
//        }
//    
//    private func moveToNextStory() {
//            let totalStories = DataController.shared.getNumberOfStories()
//            if currentStoryIndex != nil {
//                if currentStoryIndex! < totalStories - 1 {
//                    currentStoryIndex! += 1
//                    currentSceneIndex = 0
//                    currentSceneTextIndex = 0
//                    showMCQScene = false
//                    showFinalScene = false
//                } else {
//                    currentStoryIndex = -1
//                    currentSceneIndex = 0
//                    currentSceneTextIndex = 0
//                    showMCQScene = false
//                    showFinalScene = false
//                }
//                storedStoryIndex = currentStoryIndex!
//            }
//        }
//}
//
//
//
//struct MenuView: View {
//    @Binding var currentStoryIndex: Int?
//    @Binding var currentSceneIndex: Int
//    @Binding var currentSceneTextIndex: Int
//    @Binding var showMCQScene: Bool
//    @Binding var showFinalScene: Bool
//    @Binding var menuOpened: Bool
//    private let totalStories = DataController.shared.getNumberOfStories()
//    private let allStoriesTitle = DataController.shared.getAllTitlesOfStories()
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(allStoriesTitle.indices, id: \.self) { index in
//                    HStack {
//                        Image(systemName: index <= (currentStoryIndex ?? 0) - 1 ? "circle.fill" : "circle")
//                            .foregroundStyle(Color.accentColor)
//                        Text(allStoriesTitle[index])
//                        Spacer()
//                    }
//                    .listRowSeparator(.hidden)
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        currentStoryIndex = index
//                        currentSceneIndex = 0
//                        currentSceneTextIndex = 0
//                        showMCQScene = false
//                        showFinalScene = false
//                        menuOpened = false
//                    }
//                }
//            }
//        }
//        .listStyle(.insetGrouped)
//        .animation(.bouncy, value: true)
//    }
//}
//
//#Preview {
//    SvaraaLifeView()
//}
//
//

import SwiftUI

struct SvaraaLifeView: View {
    @AppStorage("currentStoryIndex") private var storedStoryIndex: Int = -1
    @State private var currentStoryIndex: Int = -1
    @State private var currentSceneIndex: Int = 0
    @State private var currentSceneTextIndex: Int = 0
    @State private var showMCQScene: Bool = false
    @State private var showFinalScene: Bool = false
    @State private var moveToCenter = false
    @State private var moveToLeft = false
    @State private var menuOpened: Bool = false
    
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
                    if currentStoryIndex == -1 {
                        // First tap: Load the stored index
                        currentStoryIndex = storedStoryIndex
                    } else {
                        progressStory()
                    }
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
                            .frame(width: 300)
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
                
                if menuOpened {
                    MenuView(
                        currentStoryIndex: $currentStoryIndex,
                        currentSceneIndex: $currentSceneIndex,
                        currentSceneTextIndex: $currentSceneTextIndex,
                        showMCQScene: $showMCQScene,
                        showFinalScene: $showFinalScene,
                        menuOpened: $menuOpened
                    )
                }
                
                VStack {
                    HStack(alignment: .top) {
                        Button("", systemImage: "list.dash") {
                            menuOpened.toggle()
                        }
                        .imageScale(.large)
                        .buttonStyle(.automatic)
                        .padding()
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    
    private func restartAnimation(geometry: GeometryProxy) {
        moveToCenter = false
        moveToLeft = false

        withAnimation(.bouncy(duration: 1)) {
            moveToCenter = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
                storedStoryIndex = 0
                currentSceneIndex = 0
                currentSceneTextIndex = 0
                showMCQScene = false
                showFinalScene = false
            }
            return
        }

        guard currentStoryIndex < totalStories else {
            print("Error: Out-of-bounds story index.")
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
            storedStoryIndex = currentStoryIndex
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            showMCQScene = false
            showFinalScene = false
        } else {
            currentStoryIndex = -1
            storedStoryIndex = -1
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            showMCQScene = false
            showFinalScene = false
        }
    }
}

struct MenuView: View {
    @Binding var currentStoryIndex: Int
    @Binding var currentSceneIndex: Int
    @Binding var currentSceneTextIndex: Int
    @Binding var showMCQScene: Bool
    @Binding var showFinalScene: Bool
    @Binding var menuOpened: Bool
    @AppStorage("currentStoryIndex") private var storedStoryIndex: Int = -1
    private let totalStories = DataController.shared.getNumberOfStories()
    private let allStoriesTitle = DataController.shared.getAllTitlesOfStories()

    var body: some View {
        VStack {
            List {
                ForEach(allStoriesTitle.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: index <= currentStoryIndex - 1 ? "circle.fill" : "circle")
                            .foregroundStyle(Color.accentColor)
                        Text(allStoriesTitle[index])
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        currentStoryIndex = index
                        storedStoryIndex = index
                        currentSceneIndex = 0
                        currentSceneTextIndex = 0
                        showMCQScene = false
                        showFinalScene = false
                        menuOpened = false
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .animation(.bouncy, value: true)
    }
}

#Preview {
    SvaraaLifeView()
}
