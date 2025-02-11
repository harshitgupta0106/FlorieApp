//
//  File.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//

import Foundation


//Creating Singleton class
struct DataController {
    private var user: User?
    
    static let shared = DataController()
    func getUserName() -> String {
        if let userName = user?.name {
            return userName
        } else {
            return "User"
        }
    }
    
    func getUserAge() -> Int {
        if let userAge = user?.age {
            return userAge
        } else {
            return Int.max //considering all age's diseases
        }
    }
}
