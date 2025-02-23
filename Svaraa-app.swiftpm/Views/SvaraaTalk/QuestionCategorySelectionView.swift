
import SwiftUI

struct QuestionCategorySelectionView: View {
    @Binding var isShowingQuestionSelector: Bool
    @Binding var isConversing: Bool
    let categories = DataController.shared.getAllQuestionCategories()
    let onQuestionSelected: (QAItem) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible())], spacing: 12) {
                ForEach(categories.indices, id: \.self) { index in
                    let row = index / 2
                    let col = index % 2
                    let isEvenDiagonal = (row + col) % 2 == 0
                    
                    NavigationLink {
                        QuestionListView(isConversing: $isConversing, isShowingQuestionSelector: $isShowingQuestionSelector, category: categories[index], onSelect: onQuestionSelected)
                    }
                    label: {
                        Text(categories[index].name)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(Color(hex: isEvenDiagonal ? "#DBBBF5" : "#DDF0FF"))
                            .foregroundColor(Color(hex: "#504136"))
                            .cornerRadius(12)
//                            .shadow(radius: 3)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Choose a Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuestionListView: View {
    @Binding var isConversing: Bool
    @Binding var isShowingQuestionSelector: Bool
    let category: QuestionCategory
    let onSelect: (QAItem) -> Void
    
    var body: some View {
        List(category.items) { item in
            Button(action: {
                onSelect(item)
                isShowingQuestionSelector = false
                isConversing = true
            }) {
                VStack(alignment: .leading) {
                    Text(item.question)
                        .foregroundColor(.primary)
                    Text("Tap to see answer")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle(category.name)
    }
}


//#Preview {
//    FrameQuestionView()
//}
