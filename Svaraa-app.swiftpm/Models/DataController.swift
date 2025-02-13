//
//  File.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//

import Foundation


//Creating Singleton class
@MainActor
class DataController {
    private var user: User?
    private var gameScenes: [GameScene] = []
    static let shared = DataController()
    
    private init() {
        loadData()
    }
    //MARK: - Data filling
    
    func loadData() {
        gameScenes = [
            GameScene(description: "First Scene", backgroundImageName: "Bedroom", svaraaImageName: "Svaraa_Happy", choices: nil, nextSceneID: nil)
        ]
    }
    
    //MARK: - Svaraa's Life functions
    
    func currentGameScene(index: Int) -> GameScene{
        gameScenes[index]
    }
    
    func wrongChoice(backgroundImage: String, description: String) -> GameScene {
        GameScene(description: description, backgroundImageName: backgroundImage, svaraaImageName: "Svaraa_Happy", choices: nil, nextSceneID: nil)
    }
    
    //MARK: - User functions
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
