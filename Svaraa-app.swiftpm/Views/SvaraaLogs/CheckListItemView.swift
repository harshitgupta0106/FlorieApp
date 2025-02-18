//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 18/02/25.
//

import SwiftUI

//struct CheckBoxListItemView: View {
//    
//    //when user click: checkmark.square.fill
//    
//    //sample array
//    var checkListItems: [String] = ["A", "h", "gj"]
//    var body: some View {
//        List {
//            ForEach(checkListItems) { item in
//                HStack {
//                    Button("", systemImage: "square") {
//                        
//                    }
//                    Text(item)
//                }
//                .listRowSeparator(.hidden)
//            }
//        }
//        .listStyle(.plain)
//    }
//}

import SwiftUI

//struct CheckBoxListItemView: View {
//    var timeOfDay: ChecklistCategory
//    @State private var checkListItems: [CheckListItem]
//    
//    init(timeOfDay: ChecklistCategory, checkListItems: [CheckListItem]) {
//        self.timeOfDay = timeOfDay
//        self._checkListItems = State(initialValue: checkListItems)
//    }
//
//    var body: some View {
//        List {
//            ForEach(checkListItems.indices, id: \.self) { index in
//                HStack {
//                    Button(action: {
//                        let updatedItem = checkListItems[index].toggleChecked()
//                        checkListItems[index] = updatedItem
//                        DataController.shared.toggleCheckItem(checkListIndex: 0, category: timeOfDay, itemIndex: index)
//
//                    }) {
//                        Image(systemName: checkListItems[index].isChecked ? "checkmark.square.fill" : "square")
//                            .foregroundColor(.blue)
//                    }
//                    Text(checkListItems[index].name)
//                }
//            }
//        }
//        .listStyle(.plain)
//    }
//}
//
//extension CheckListItem {
//    func toggleChecked() -> CheckListItem {
//        var newItem = self
//        newItem.isChecked.toggle()
//        return newItem
//    }
//}

struct CheckBoxListItemView: View {
    var timeOfDay: ChecklistCategory
    @Binding var checkListItems: [CheckListItem]

    var body: some View {
        List {
            ForEach(checkListItems.indices, id: \.self) { index in
                HStack {
                    Button(action: {
                        checkListItems[index].isChecked.toggle()
                        DataController.shared.toggleCheckItem(checkListIndex: 0, category: timeOfDay, itemIndex: index)
                    }) {
                        Image(systemName: checkListItems[index].isChecked ? "checkmark.square.fill" : "square")
                            .foregroundColor(.blue)
                    }
                    Text(checkListItems[index].name)
                }
            }
        }
        .listStyle(.plain)
    }
}


//#Preview {
//    CheckBoxListItemView()
//}
