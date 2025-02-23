//
//  SwiftUIView.swift
//  Svaraa
//
//  Created by Harshit Gupta on 18/02/25.
//

import SwiftUI


struct CheckBoxListItemView: View {
    @Binding var selectedTimeOfDay: ChecklistCategory
    @Binding var checkList: CheckList
    @Binding var isSheetPresented: Bool
    let generator = UIImpactFeedbackGenerator(style: .light)
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: {
                    isSheetPresented = false
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                Spacer()
            }
            .background(Color.clear)
            .padding()
            
            List {
                ForEach(getTimeOfDay().indices, id: \.self) { index in
                    let isEven = index % 2 == 0
                    Button(action: {
                        toggleCheckItem(index: index)
                    }) {
                        HStack(spacing: 10) {
                            Group {
                                if getTimeOfDay()[index].isChecked {
                                    Image("Svaraa_Tick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50) // Ensure consistent size
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(Color(hex: "#504136"))
                                        .font(.system(size: 20))
                                        .frame(width: 40, height: 40)
                                }
                            }
                            .frame(width: 50, alignment: .leading)

                            Text(getTimeOfDay()[index].name)
                                .foregroundStyle(Color(hex: "#504136"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 22)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: isEven ? "#DBBBF5" : "#DDF0FF"))
                    .cornerRadius(12)
                    .padding(.vertical, 10)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(Visibility.hidden)
                }
                .listStyle(.plain)
            }
        }
    }
    
    func getTimeOfDay() -> [CheckListItem] {
        switch selectedTimeOfDay {
        case .morning:
            return checkList.morningList
        case .afternoon:
            return checkList.afternoonList
        case .evening:
            return checkList.eveningList
        case .night:
            return checkList.nightList
        case .common:
            return checkList.commonList
        }
    }
    
    func toggleCheckItem(index: Int) {
        switch selectedTimeOfDay {
        case .morning:
            checkList.morningList[index].isChecked.toggle()
        case .afternoon:
            checkList.afternoonList[index].isChecked.toggle()
        case .evening:
            checkList.eveningList[index].isChecked.toggle()
        case .night:
            checkList.nightList[index].isChecked.toggle()
        case .common:
            checkList.commonList[index].isChecked.toggle()
        }
        generator.impactOccurred()
        DataController.shared.toggleCheckItem(checkListIndex: 0, category: selectedTimeOfDay, itemIndex: index)
    }
}
