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
                    let isEven = index % 2 == 0 
                    let backgroundColor = Color(hex: isEven ? "#DBBBF5" : "#DDF0FF")
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
                    .foregroundStyle(Color(hex: "#504136"))
                    .frame(width: 360,height: 170)
                    .listRowSeparator(.hidden)
                    .background(backgroundColor)
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
        
        DispatchQueue.main.async {
            menuOpened = false
            
            currentStoryIndex = index
            storedStoryIndex = index
            currentSceneIndex = 0
            currentSceneTextIndex = 0
            showMCQScene = false
            showFinalScene = false
        }
    }


}

