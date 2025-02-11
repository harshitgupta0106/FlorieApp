//
//  File.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//

import Foundation
import SwiftUI

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
