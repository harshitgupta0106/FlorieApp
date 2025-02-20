import SwiftUI

struct CheckListView: View {
    @State var checkList: CheckList? = DataController.shared.getPCOSCheckList()
    @State private var selectedList: [CheckListItem] = []
    @State private var isSheetPresented: Bool = false
    @State private var selectedTimeOfDay: ChecklistCategory = .morning


    var body: some View {
        if let checkList {
            ScrollView {
                VStack(alignment: .center, spacing: 15) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(String(format: "%.0f", checkList.progress))%")
                                .font(.title)
                                .bold()
                            Text("Overall progress")
                                .font(.headline)
                            ProgressView(value: checkList.progress, total: 100)
                        }
                        .padding(15)
                        Spacer()
                    }

                    HStack(alignment: .center, spacing: 15) {
                        CheckListItemView(
                            checkListItemName: "Morning",
                            isSmall: true,
                            imageName: "Morning",
                            bgColor: "#A86CB8",
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
                            imageName: "Afternoon",
                            bgColor: "#83A852",
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
                            imageName: "Evening",
                            bgColor: "#0097B2",
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
                            imageName: "Night",
                            bgColor: "#EF8E6D",
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
                        imageName: "Common",
                        bgColor: "#A86CB8",
                        checkListItems: checkList.commonList,
                        onTap: {
                            selectedList = checkList.commonList
                            selectedTimeOfDay = .common
                            isSheetPresented = true
                        }
                    )
                    Spacer()
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                CheckBoxListItemView(timeOfDay: selectedTimeOfDay, checkListItems: $selectedList)
            }


        }
    }
}

struct CheckListItemView: View {
    var checkListItemName: String
    var isSmall: Bool
    var imageName: String
    var bgColor: String
    var checkListItems: [CheckListItem]
    var onTap: () -> Void  // Closure for handling tap event
//    @State var checkedItem: Int = 0
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
//                Text("\(checkedItem)/\(checkListItems.count)")
                Text("1/\(checkListItems.count)")
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
            .foregroundStyle(Color.white)
        }
        .frame(width: isSmall ? 150 : 345, height: 150)
        .padding()
        .background(Color(hex: bgColor))
        .cornerRadius(12)
        .onTapGesture {
            onTap()  // Call the closure to update selectedList & show sheet
        }
    }
    
//    func calculateCheckedItems() -> Int {
//        checkedItem = checkListItems.reduce(into: 0) { result, item in
//            if item.isChecked {
//                result += 1
//            }
//        }
//    }
}



#Preview {
    CheckListView()
}
