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
    private var stories: [Story] = []
    static let shared = DataController()
    
    private init() {
        loadData()
    }
    //MARK: - Data filling
    
    func loadData() {
        stories = [
            Story(
                title: "Svaraa’s Big Day: A Story of Growing Up",
                storyScenes: [
                    StoryScene(
                        descriptions: [
                            "Today is a special day—Svaraa’s birthday! She’s turning 12, and everything feels magical.",
                            "Balloons fill the room, her friends are arriving, and she’s got the prettiest dress on.",
                            ],
                        backgroundImageName: "",
                        svaraaImageName: "Svaraa_VeryHappy"
                    ),
                    StoryScene(
                        descriptions: [
                            "But… something feels different today.",
                            "As she laughs with her best friend, Anaya, Svaraa suddenly feels a strange wetness in her underwear.",
                            "Confused, she rushes to the bathroom. Her heart pounds as she looks down and sees something unexpected—a deep red stain on her favorite dress.",
                            "Her mind races. Is something wrong with me?",
                            "She remembers a health class where they mentioned something about periods.",
                            "But no one really talked about what it feels like to get one for the first time."
                        ],
                        backgroundImageName: "",
                        svaraaImageName: "Svaraa_Shocked")
                ],
                mcqScene: MCQScene(
                        question: "What should Svaraa do next?",
                        options: [
                            "Panic and hide it from everyone.",
                            "Use tissue paper and hope it stops.",
                            "Find an elder she trusts and ask for help.",
                            "Ignore it and continue with the party."
                            ],
                        correctOptionIndex: 2,
                        backgroundImageName: "",
                        svaraaImageName: "Svaraa_Shocked"

                ),
                finalScene: StoryScene(
                    descriptions: [
                            "Svaraa hesitates, but then she takes a deep breath and calls her mom.",
                            "\"Mom, I think I started my period.\"",
                            "Her mother smiles gently, \"That’s wonderful, Svaraa. This is a sign that you’re growing up.\"",
                            "She helps Svaraa change into fresh clothes and hands her a pad. \"This will keep you comfortable. Let’s talk about how to use it.\""
                    ],
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Satisfied"
                )
            )
        ]
    }
    
    //MARK: - Svaraa's Life functions
    
    func getAllStories() -> [Story] {
        stories
    }
    
    func getNumberOfStories() -> Int {
        stories.count
    }
    
    func getStory(at index: Int) -> Story {
        stories[index]
    }
    
    func getAllStoryScenes(ofStoryIndex index: Int) -> [StoryScene] {
        stories[index].storyScenes
    }
    
    func getNumberOfStoryScenes(ofStoryIndex index: Int) -> Int {
        stories[index].storyScenes.count
    }
    
    func getStoryScene(ofStoryIndex index: Int, sceneIndex: Int) -> StoryScene {
        stories[index].storyScenes[sceneIndex]
    }
    
    func getFinalScene(ofStoryIndex index: Int) -> StoryScene {
        stories[index].finalScene
    }
    
    func getTitleOfStory(ofStoryIndex index: Int) -> String {
        stories[index].title
    }
    
    func getMCQScene(ofStoryIndex index: Int) -> MCQScene {
        stories[index].mcqScene
    }
    
    func getNumberOfDescriptionsInScene(ofStoryIndex index: Int, sceneIndex: Int) -> Int {
        stories[index].storyScenes[sceneIndex].descriptions.count
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
