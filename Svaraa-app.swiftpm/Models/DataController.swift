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
    private var user: User =
    User(
        name: UserDefaults.standard.string(forKey: "userName") ?? "User",
        age: UserDefaults.standard.integer(forKey: "userAge") == 0 ? Int.max : UserDefaults.standard.integer(forKey: "userAge")
    )
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
                        "Svaraa hesitates, then calls her mom. \"Mom, I think I started my period.\"\n\nHer mom smiles warmly. \"That's wonderful! You’re growing up.\"\n\nShe gives Svaraa a pad. \"This will keep you comfortable. Let’s go over how to use it.\""
                    ],
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Satisfied"
                )
            ),
            
            Story(
                title: "Understanding Periods & Breaking Taboos",
                storyScenes: [
                    StoryScene(
                        descriptions: [
                            "Later that night, Svaraa sits on her bed, thinking about everything. She has so many questions. She texts Anaya:",
                            "Svaraa: \"Hey, I got my period today 😳\"",
                            "Anaya: \"Omg, really? I haven’t gotten mine yet. Does it hurt?\"",
                            "Svaraa: \"Not really, but I feel weird. Also, why don’t people talk about this more?\""
                        ],
                        backgroundImageName: "",
                        svaraaImageName: "Svaraa_Casual"
                    ),
                    StoryScene(
                        descriptions: [
                            "Her mother knocks on the door. \"Hey, Svaraa. Want to ask me anything?\""
                        ],
                        backgroundImageName: "",
                        svaraaImageName: "Svaraa_Shocked"
                    )
                ],
                mcqScene: MCQScene(
                    question: "What should Svaraa ask?",
                    options: [
                        "Can I go swimming during my period?",
                        "Will everyone know I’m on my period?",
                        "Why do some people think periods are ‘dirty’?",
                        "All of the above."
                    ],
                    correctOptionIndex: 3,
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Curious"
                ),
                finalScene: StoryScene(
                    descriptions: [
                        "There are so many questions worth asking!\n\nThere are a lot of myths about periods.\n\nSome people believe girls shouldn’t touch pickles or enter temples during their cycle—but those are just taboos, not science. \n\nYou can do everything you normally do, just with a little extra care."
                    ],
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Smiling"
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
        user.name
    }
    
    func setUserName(name: String) {
        user.name = name
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    func getUserAge() -> Int {
        user.age
    }
    
    func setUserAge(age: Int) {
        user.age = age
        UserDefaults.standard.set(age, forKey: "userAge")
    }
}
