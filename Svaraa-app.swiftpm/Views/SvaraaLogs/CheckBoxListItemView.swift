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
                // Use the list returned by getTimeOfDay()
                ForEach(getTimeOfDay().indices, id: \.self) { index in
//                    HStack {
                    Button(action: {
                        toggleCheckItem(index: index)
                    }) {
                        HStack(spacing: 10) {
                            // Fix icon width
                            Group {
                                if getTimeOfDay()[index].isChecked {
                                    Image("Svaraa_Tick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50) // Ensure consistent size
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .frame(width: 40, height: 40) // Same width as tick
                                }
                            }
                            .frame(width: 50, alignment: .leading) // Ensure fixed width for all icons

                            // Text alignment fix
                            Text(getTimeOfDay()[index].name)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 22)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .onTapGesture {
                        generator.impactOccurred()
                    }
                    .padding(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.accentColor.opacity(0.8))
                    .cornerRadius(12)
                    .padding(.vertical, 10)// Ensure row starts at same point
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) // Remove extra padding
                    .listRowBackground(Color.clear)
                    .listRowSeparator(Visibility.hidden)
//                        Button(action: {
//                            // Toggle the checkbox and update the state
//                            toggleCheckItem(index: index)
//                        }) {
//                            HStack(spacing: 10) {
//                                if getTimeOfDay()[index].isChecked {
//                                    Image("Svaraa_Tick")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 50)
//                                } else {
//                                    Image(systemName: "circle")
//                                        .foregroundColor(.accentColor)
//                                        .font(.system(size: 20))
//                                        .frame(width: 50)
//                                }
//                                Text(getTimeOfDay()[index].name)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding(.vertical, 22)
//                                    .multilineTextAlignment(.leading)
//                            }
//                        }
//                        .frame(width: 350)
//                        .buttonStyle(.borderedProminent)
////                    }
//                    .listRowSeparator(Visibility.hidden)
//                    .listRowBackground(Color.clear)
                    
                }
                .listStyle(.plain)
            }
        }
    }
    
    // Helper function to get the correct list based on timeOfDay
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
    
    // Helper function to toggle the checkbox and update the state
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
        
        // Save the updated state
        DataController.shared.toggleCheckItem(checkListIndex: 0, category: selectedTimeOfDay, itemIndex: index)
    }
}
