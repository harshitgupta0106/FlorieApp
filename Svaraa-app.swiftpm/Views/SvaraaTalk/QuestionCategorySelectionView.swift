//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 22/02/25.
//

import SwiftUI

struct QuestionCategorySelectionView: View {
    @Binding var isShowingQuestionSelector: Bool
    @Binding var isConversing: Bool
    let categories = DataController.shared.getAllQuestionCategories()
    let onQuestionSelected: (QAItem) -> Void
    
    var body: some View {
//        List {
//            ForEach(categories) { category in
//                NavigationLink {
//                    QuestionListView(isConversing: $isConversing, isShowingQuestionSelector: $isShowingQuestionSelector, category: category, onSelect: onQuestionSelected)
//                }
//                label: {
//                    Text(category.name)
//                        .padding()
//                        .frame(maxWidth: .infinity, minHeight: 50)
//                        .background(Color(hex: "#564A73"))
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .shadow(radius: 3)
//                }
//                .listRowSeparator(.hidden)
//            }
//        }
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible())], spacing: 12) {
                ForEach(categories) { category in
                    NavigationLink {
                        QuestionListView(isConversing: $isConversing, isShowingQuestionSelector: $isShowingQuestionSelector, category: category, onSelect: onQuestionSelected)
                    }
                    label: {
                        Text(category.name)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(Color(hex: "#564A73"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
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
