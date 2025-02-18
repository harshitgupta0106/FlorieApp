//
//  File.swift
//  Svaraa
//
//  Created by Harshit Gupta on 18/02/25.
//

import Foundation
import SwiftUI

struct CheckList: Identifiable, Codable {
    let id = UUID()
    var name: String
    var description: String
    
    var morningList: [CheckListItem]
    var afternoonList: [CheckListItem]
    var eveningList: [CheckListItem]
    var nightList: [CheckListItem]
    var commonList: [CheckListItem]
    
    var progress: Double {
        let totalItems = morningList + afternoonList + eveningList + nightList + commonList
        let checkedItemsCount = totalItems.filter { $0.isChecked }.count
        return totalItems.isEmpty ? 0 : round(Double(checkedItemsCount) / Double(totalItems.count) * 100)
    }
}




struct CheckListItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var isChecked: Bool
    
    init(name: String, isChecked: Bool = false) {
        self.id = UUID()
        self.name = name
        self.isChecked = isChecked
    }
}

enum ChecklistCategory: String, CaseIterable {
    case morning, afternoon, evening, night, common
}

