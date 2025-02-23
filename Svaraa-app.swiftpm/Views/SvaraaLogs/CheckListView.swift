import SwiftUI
struct CheckListView: View {
    @State var checkList: CheckList = DataController.shared.getPCOSCheckList()
    @State private var selectedList: [CheckListItem] = []
    @State var isSheetPresented: Bool = false
    @State private var selectedTimeOfDay: ChecklistCategory = .morning
    @State var overallProgress: Double = DataController.shared.getCheckListsProgress()

    var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: 15) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(String(format: "%.0f", overallProgress))%")
                                .font(.title)
                                .bold()
                            Text("Overall progress")
                                .font(.headline)
                            ProgressView(value: overallProgress, total: 100)
                        }
                        .padding(15)
                        Spacer()
                    }

                    HStack(alignment: .center, spacing: 15) {
                        CheckListItemView(
                            checkListItemName: "Morning",
                            isSmall: true,
                            imageName: "Morning",
                            bg: "#DBBBF5",
                            checkListItems: checkList.morningList,
                            onTap: {
                                selectedList = checkList.morningList
                                selectedTimeOfDay = .morning
                                isSheetPresented = true
                            }
                        )
                        CheckListItemView(
                            checkListItemName: "Afternoon",
                            isSmall: true,
                            imageName: "Afternoon", bg: "#DDF0FF",
                            checkListItems: checkList.afternoonList,
                            onTap: {
                                selectedList = checkList.afternoonList
                                selectedTimeOfDay = .afternoon
                                isSheetPresented = true
                            }
                        )
                    }
                    HStack(alignment: .center, spacing: 15) {
                        CheckListItemView(
                            checkListItemName: "Evening",
                            isSmall: true,
                            imageName: "Evening", bg: "#DDF0FF",
                            checkListItems: checkList.eveningList,
                            onTap: {
                                selectedList = checkList.eveningList
                                selectedTimeOfDay = .evening
                                isSheetPresented = true
                            }
                        )
                        CheckListItemView(
                            checkListItemName: "Night",
                            isSmall: true,
                            imageName: "Night", bg: "#DBBBF5",
                            checkListItems: checkList.nightList,
                            onTap: {
                                selectedList = checkList.morningList
                                selectedTimeOfDay = .night
                                isSheetPresented = true
                            }

                        )
                    }

                    CheckListItemView(
                        checkListItemName: "Whole day common",
                        isSmall: false,
                        imageName: "Common", bg: "#DBBBF5",
                        checkListItems: checkList.commonList,
                        onTap: {
                            selectedList = checkList.commonList
                            selectedTimeOfDay = .common
                            isSheetPresented = true
                        }
                    )
                    Spacer()
                }
                .onAppear {
                    overallProgress = DataController.shared.getCheckListsProgress()
                }
            }
            .sheet(isPresented: $isSheetPresented, onDismiss: {
                overallProgress = DataController.shared.getCheckListsProgress()
            }) {
                CheckBoxListItemView(selectedTimeOfDay: $selectedTimeOfDay, checkList: $checkList, isSheetPresented: $isSheetPresented)
            }
    }
}

struct CheckListItemView: View {
    var checkListItemName: String
    var isSmall: Bool
    var imageName: String
    var bg: String
    var checkListItems: [CheckListItem]
    var onTap: () -> Void
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("\(completedTasksCount(for: checkListItems))/\(checkListItems.count)")
                    .font(.headline)
                Text(checkListItemName)
                    .font(.subheadline)
                HStack {
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                }
            }
            .foregroundStyle(Color(hex: "#504136"))
        }
        .frame(width: isSmall ? 150 : 345, height: 150)
        .padding()
        .background(Color(hex: bg))
        .cornerRadius(12)
//        .shadow(radius: 3)
        .onTapGesture {
            onTap()  // Call the closure to update selectedList & show sheet
        }
    }
    
    func completedTasksCount(for list: [CheckListItem]) -> Int {
        return list.filter { $0.isChecked }.count
    }
}

#Preview {
    CheckListView()
}


//struct CheckListView: View {
//    @ObservedObject var dataController = DataController.shared
//    @State private var isSheetPresented: Bool = false
//    @State private var selectedTimeOfDay: ChecklistCategory = .morning
//    @State private var selectedCheckListId: UUID?
//    
//    var body: some View {
//        ScrollView {
//            if let checkList = dataController.getPCOSCheckList() {
//                VStack(alignment: .center, spacing: 15) {
//                    ProgressSection(checkList: checkList)
//                    TimeOfDayButtons(checkList: checkList,
//                                    selectedTimeOfDay: $selectedTimeOfDay,
//                                    isSheetPresented: $isSheetPresented,
//                                    selectedCheckListId: $selectedCheckListId)
//                }
//            }
//        }
//        .sheet(isPresented: $isSheetPresented) {
//            if let checkListId = selectedCheckListId {
//                CheckBoxListItemView(checkListId: checkListId,
//                                     timeOfDay: selectedTimeOfDay,
//                                     isSheetPresented: $isSheetPresented)
//            }
//        }
//    }
//}
//
//struct ProgressSection: View {
//    let checkList: CheckList
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text("\(String(format: "%.0f", checkList.progress))%")
//                    .font(.title).bold()
//                Text("Overall progress").font(.headline)
//                ProgressView(value: checkList.progress, total: 100)
//            }
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//struct TimeOfDayButtons: View {
//    let checkList: CheckList
//    @Binding var selectedTimeOfDay: ChecklistCategory
//    @Binding var isSheetPresented: Bool
//    @Binding var selectedCheckListId: UUID?
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            HStack(spacing: 10) {
//                TimeOfDayButton(category: .morning, checkList: checkList,
//                                selectedTimeOfDay: $selectedTimeOfDay,
//                                isSheetPresented: $isSheetPresented,
//                                selectedCheckListId: $selectedCheckListId)
//                TimeOfDayButton(category: .afternoon, checkList: checkList,
//                                selectedTimeOfDay: $selectedTimeOfDay,
//                                isSheetPresented: $isSheetPresented,
//                                selectedCheckListId: $selectedCheckListId)
//            }
//            HStack {
//                TimeOfDayButton(category: .evening, checkList: checkList,
//                                selectedTimeOfDay: $selectedTimeOfDay,
//                                isSheetPresented: $isSheetPresented,
//                                selectedCheckListId: $selectedCheckListId)
//                TimeOfDayButton(category: .night, checkList: checkList,
//                                selectedTimeOfDay: $selectedTimeOfDay,
//                                isSheetPresented: $isSheetPresented,
//                                selectedCheckListId: $selectedCheckListId)
//            }
//            TimeOfDayButton(category: .common, checkList: checkList,
//                            selectedTimeOfDay: $selectedTimeOfDay,
//                            isSheetPresented: $isSheetPresented,
//                            selectedCheckListId: $selectedCheckListId,
//                            isFullWidth: true)
//        }
//    }
//}
//
//struct TimeOfDayButton: View {
//    let category: ChecklistCategory
//    let checkList: CheckList
//    @Binding var selectedTimeOfDay: ChecklistCategory
//    @Binding var isSheetPresented: Bool
//    @Binding var selectedCheckListId: UUID?
//    var isFullWidth: Bool = false
//    
//    var items: [CheckListItem] {
//        checkList.getItems(for: category)
//    }
//    
//    var body: some View {
//        Button(action: {
//            selectedTimeOfDay = category
//            selectedCheckListId = checkList.id
//            isSheetPresented = true
//        }) {
//            ZStack {
//                VStack(alignment: .leading) {
//                    Text("1/\(items.count)")
//                        .font(.headline)
//                    Text("checkListItemName")
//                        .font(.subheadline)
//                    HStack {
//                        Spacer()
////                        Image(imageName)
////                            .resizable()
////                            .scaledToFit()
//                    }
//                }
//                .foregroundStyle(Color.white)
//            }
//            .frame(width: !isFullWidth ? 150 : 345, height: 150)
//            .padding()
//            .background(Color.accentColor.opacity(0.8))
//            .cornerRadius(12)
//        }
//        .frame(width: isFullWidth ? 345 : 150, height: 150)
//    }
//}
