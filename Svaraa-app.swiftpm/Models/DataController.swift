//
//  File.swift
//  Florie-app
//
//  Created by Harshit Gupta on 06/02/25.
//

import Foundation
import CodableCSV


//Creating Singleton class
@MainActor
class DataController: ObservableObject {
    private var user: User =
    User(
        name: UserDefaults.standard.string(forKey: "userName") ?? "User",
        age: UserDefaults.standard.integer(forKey: "userAge") == 0 ? Int.max : UserDefaults.standard.integer(forKey: "userAge")
    )
    
    private var qaDictionary: [String : String] = [:]
    private var pcodDetectQuestions: [String] = []
    private var pcosDetectQuestions: [String] = []
    private var questionCategories: [QuestionCategory] = []
    
    private var stories: [Story] = []
    
    private var checkLists: [CheckList] = []
    
    static let shared = DataController()
    
    private init() {
        loadData()
        loadCheckLists()
        loadQA()
//        print(qaDictionary)
    }
    //MARK: - Data filling
    
    func loadData() {
        stories = [
            Story(
                storyImage: "pad",
                title: "Svaraa’s Big Day: \nA Story of Growing Up",
                storyScenes: [
                    StoryScene(
                        descriptions: [
                            "Today is a special day—Svaraa’s birthday! She’s turning 12, and everything feels magical.",
                            "Balloons fill the room, her friends are arriving, and she’s got the prettiest dress on.",
                            ],
                        backgroundImageName: "birthday-bg",
                        svaraaImageName: "Svaraa_VeryHappy"
                    ),
                    StoryScene(
                        descriptions: [
                            "But… something feels different today.",
                            "As she laughs with her best friend, Anaya, Svaraa suddenly feels a strange wetness in her underwear."
                        ],
                        backgroundImageName: "birthday-bg",
                        svaraaImageName: "Svaraa_Shocked"
                    ),
                    StoryScene(
                        descriptions: [
                            "Confused, she rushes to the bathroom.",
                            "Her heart pounds as she looks down and sees something unexpected—a deep red stain on her favorite dress.",
                            "Her mind races. Is something wrong with me?",
                            "She remembers a health class where they mentioned something about periods.",
                            "But no one really talked about what it feels like to get one for the first time."
                        ],
                        backgroundImageName: "washroom-bg",
                        svaraaImageName: "Svaraa_Shocked"
                    )
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
                        svaraaImageName: "Svaraa_Question"

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
                storyImage: "uti",
                title: "Svaraa’s Silent Struggle: \nA Lesson on UTIs",
                storyScenes: [
                    StoryScene(
                        descriptions: [
                            "Svaraa had settled into hostel life—early morning lectures, late-night study sessions, and endless cups of chai. ",
                            "She was so busy that she barely noticed small changes in her body.",
                            "One evening, after rushing back from the library, she felt a burning sensation while urinating.",
                            "\"Maybe I didn’t drink enough water,\" she thought and ignored it."
                        ],
                        backgroundImageName: "bedroom-bg",
                        svaraaImageName: "Svaraa_Happy"
                    ),StoryScene(
                        descriptions: [
                            "One evening, after rushing back from the library, she felt a burning sensation while urinating.",
                            "\"Maybe I didn’t drink enough water,\" she thought and ignored it.",
                            "Days passed, and the discomfort increased. She felt the urge to pee frequently, but only a few drops would come out—each time with a painful sting."
                        ],
                        backgroundImageName: "washroom-bg",
                        svaraaImageName: "Svaraa_Confused"
                    ),
                    StoryScene(
                        descriptions: [
                            "Then, one night, she saw something alarming—a slight trace of blood in her urine."
                        ],
                        backgroundImageName: "washroom-bg",
                        svaraaImageName: "Svaraa_Crying"
                    )
                ],
                mcqScene: MCQScene(
                    question: "What should Svaraa do now?",
                    options: [
                        "Drink more water and wait for it to go away.",
                        "Ignore it—it’s probably nothing serious.",
                        "Ask a senior or warden for help.",
                        "Take random medicine from a friend."
                    ],
                    correctOptionIndex: 2,
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Question"
                ),
                finalScene: StoryScene(
                    descriptions: [
                        "Ignoring UTI symptoms can lead to kidney infections. Drinking water helps, but only a doctor can provide the right treatment. \n\nSeeking help from trusted elders or a healthcare professional, early prevents complications!"
                    ],
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Smiling"
                )
            ),
            
            Story(
                storyImage: "yeast_infection",
                title: "The Hidden Itch: \nSvaraa’s Yeast Infection Story",
                storyScenes: [
                    StoryScene(
                        descriptions: [
                            "Life in the hostel was thrilling but hectic.",
                            "Between gym sessions, classes, and laundry delays, Svaraa often wore damp clothes or stayed in sweaty leggings for hours."
                        ],
                        backgroundImageName: "bedroom-bg",
                        svaraaImageName: "Svaraa_Happy"
                    ),StoryScene(
                        descriptions: [
                            "One morning, she felt a persistent itch down there.",
                            "She ignored it, assuming it would go away."
                        ],
                        backgroundImageName: "bedroom-bg",
                        svaraaImageName: "Svaraa_Confused"
                    ),StoryScene(
                        descriptions: [
                            "A few days later, the itching worsened, and she noticed thick, white discharge.",
                            "Sitting in lectures became unbearable.",
                            "She tried washing the area with strong soap, but that only made things worse."
                        ],
                        backgroundImageName: "",
                        svaraaImageName: "Svaraa_Crying"
                    )
                ],
                mcqScene: MCQScene(
                    question: "What should Svaraa do?",
                    options: [
                        "Ignore it—it will go away.",
                        "Use strong soap to clean the area.",
                        "Try home remedies without consulting anyone.",
                        "Speak to a senior or visit a doctor."
                    ],
                    correctOptionIndex: 3,
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Curious"
                ),
                finalScene: StoryScene(
                    descriptions: [
                        "Harsh soaps disrupt the body’s natural balance, making the infection worse. \n\nWearing clean, dry clothes and seeking medical advice is the safest option."
                    ],
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Smiling"
                )
            ),
            
            Story(
                storyImage: "pcos",
                title: "Svaraa’s Mystery: \nWhen Periods Don’t Follow the Rules",
                storyScenes: [
                    StoryScene(
                        descriptions: [
                            "Svaraa always thought her period would settle into a routine, like everyone said it would."
                        ],
                        backgroundImageName: "bedroom-bg",
                        svaraaImageName: "Svaraa_Happy"
                    ),StoryScene(
                        descriptions: [
                            "But at 16, things weren’t adding up."
                        ],
                        backgroundImageName: "",
                        svaraaImageName: "Svaraa_Casual"
                    ),StoryScene(
                        descriptions: [
                            "Some months, her period came with unbearable cramps.",
                            "Other times, it simply didn’t show up at all.",
                            "When it did, it lasted for weeks, leaving her exhausted.",
                            "She stared at the calendar app on her phone—her last period was over two months ago.",
                            "\"Maybe stress is messing it up,\" she told herself.",
                            "But deep down, she felt uneasy."
                        ],
                        backgroundImageName: "bedroom-bg",
                        svaraaImageName: "Svaraa_Dissatified"
                    ),
                    StoryScene(
                        descriptions: [
                            "Then came the sudden weight gain, the stubborn acne, and the tiny dark hairs on her chin.",
                            "No matter what she did, nothing seemed to change.",
                            "One afternoon, as she tied her hair into a ponytail, she noticed something—her hairline looked thinner.",
                            "Her stomach dropped. What was happening to her?"
                        ],
                        backgroundImageName: "bedroom-bg",
                        svaraaImageName: "Svaraa_Shocked"
                    ),
                    StoryScene(
                        descriptions: [
                            "She turned to her best friend, Anaya. \"My period’s been all over the place. And now my hair…\"",
                            "Anaya frowned. \"That doesn’t sound normal.\""
                        ],
                        backgroundImageName: "bedroom-bg",
                        svaraaImageName: "Svaraa_Crying"
                    )
                ],
                mcqScene: MCQScene(
                    question: "What should Svaraa do next?",
                    options: [
                        "Ignore it and wait for things to fix themselves.",
                        "Try random weight loss diets and acne creams.",
                        "Compare herself to others and feel discouraged",
                        "Research her symptoms, talk to a doctor, and seek proper diagnosis."
                    ],
                    correctOptionIndex: 3,
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Curious"
                ),
                finalScene: StoryScene(
                    descriptions: [
                        "Svaraa’s symptoms weren’t random—they were all connected. A visit to the doctor confirmed it: Polycystic Ovary Syndrome (PCOS). \n\nPCOS isn’t just about irregular periods. It can affect weight, skin, hair, and even mood. But with the right guidance, lifestyle changes, and sometimes medication, it can be managed.\n\nWhen Svaraa finally got the right support, things got better."
                    ],
                    backgroundImageName: "",
                    svaraaImageName: "Svaraa_Smiling"
                )
            )

        ]
        
        pcodDetectQuestions = [
            "\nWhat is your height in meters?",
            "What is your weight in kg?",
            "What is the length of your menstrual cycle?",
            "Do you have unsual bleeding? (yes/no)"
        ]
        
        pcosDetectQuestions = [
            "\nDo you feel that your menstrual cycle is Irregular? (Yes/No)",
            "What is your weight in kg?",
            "What is your height in meters?",
            "Do you experience excessive hair growth on your face or body? (Yes/No)",
            "On a scale of 0 - 3, how severe is your acne? \n(0 - None, 1 - Mild, 2 - Moderate, 3 - Severe)",
            "Do you experience hair thinning or hair loss? (Yes/No)",
            "Do you have sudden weight gain or difficulty losing weight? (Yes/No)",
            "On a scale of 1 - 3, How would you describe your stress level? \n(1 - Low, 2 - Moderate, 3 - High)",
            "How many hours of sleep do you get per night?"
        ]
        
        checkLists = [
            CheckList(
                
                name: "PCOS",
                description: "Small, consistent habits create lasting change. \n\nThis daily checklist is designed to support hormonal balance, reduce inflammation, and boost metabolism—key factors in managing PCOS & PCOD. \n\nWith mindful nutrition, movement, and recovery, you can take control of your well-being, one check at a time. ",
                
                morningList: [
                    CheckListItem(name: "Drink warm lemon water / fenugreek seed water", isChecked: false),
                    CheckListItem(name: "Eat 5 soaked almonds + 2 walnuts + 1 tsp flaxseeds", isChecked: false),
                    CheckListItem(name: "Have a high-protein breakfast (Besan chilla / Sprouts / Ragi dosa / Eggs & toast / Paneer bhurji)", isChecked: false),
                    CheckListItem(name: "10 mins meditation or deep breathing", isChecked: false),
                    CheckListItem(name: "15–30 mins light exercise (walk, Surya Namaskar)", isChecked: false)
                ],
                
                afternoonList: [
                    CheckListItem(name: "Drink 1 glass coconut water / buttermilk", isChecked: false),
                    CheckListItem(name: "Eat 1 fruit (Guava, Papaya, Apple, Pomegranate, Berries)", isChecked: false),
                    CheckListItem(name: "Eat a balanced lunch (Dal + Millet/Brown Rice + Sabzi + Curd)", isChecked: false),
                    CheckListItem(name: "Take a 10-minute post-lunch walk", isChecked: false)
                ],
                
                eveningList: [
                    CheckListItem(name: "Eat a healthy snack (Roasted chana / Makhana / Peanut butter toast / Nuts & seeds)", isChecked: false),
                    CheckListItem(name: "30–45 mins of exercise (Yoga, Strength Training, Dance, Brisk Walk)", isChecked: false),
                    CheckListItem(name: "Drink 1 cup herbal tea (Spearmint, Cinnamon, Ginger-Turmeric)", isChecked: false)
                ],
                
                nightList: [
                    CheckListItem(name: "Eat a light dinner (Moong dal khichdi + Ghee / Soup + Sautéed Veggies / 1 Roti + Sabzi + Paneer/Tofu)", isChecked: false),
                    CheckListItem(name: "Drink 1 glass warm turmeric milk (Haldi + Almond milk)", isChecked: false),
                    CheckListItem(name: "5 mins deep breathing / gratitude journaling", isChecked: false),
                    CheckListItem(name: "Sleep for 7–9 hours", isChecked: false)
                ],
                
                commonList: [
                    CheckListItem(name: "Drink 2–3 liters of water", isChecked: false),
                    CheckListItem(name: "Take 5 deep breaths before meals", isChecked: false),
                    CheckListItem(name: "Avoid screens 30 mins before bed", isChecked: false)
                ]
            )
        ]
    }
    
    func loadQA() {
        questionCategories = [
            QuestionCategory(
                name: "Menstrual Health & Cycle",
                items: [
                    QAItem(
                        question: "What is considered a normal menstrual flow?",
                        answer: "A normal menstrual flow is one that is neither too heavy nor too light. Typically, it means changing a pad or tampon every 4 to 6 hours. Your body follows its rhythm—some variations are normal."
                    ),
                    QAItem(
                        question: "I do not understand periods. What is a period?",
                        answer: "A period is the body’s way of resetting. Every month, the uterus prepares for a possible pregnancy. If that doesn’t happen, the lining sheds, leading to a period. It's natural, it's normal, and it’s a sign of a healthy cycle."
                    ),
                    QAItem(
                        question: "When did a person find out about periods?",
                        answer: "The moment of discovery is different for everyone. Some learn about it in school, others through family. It’s a journey, and the more you know, the more confident you become."
                    ),
                    QAItem(
                        question: "How long does ovulation usually last during the menstrual cycle?",
                        answer: "Ovulation typically lasts 24 to 48 hours. This is when the ovary releases an egg, making it the most fertile time in the cycle."
                    ),
                    QAItem(
                        question: "What percentage of menstruating individuals experience mood swings during their cycle?",
                        answer: "Science says nearly 75% experience mood shifts due to hormonal changes. Think of it as your body fine-tuning emotions—sometimes subtly, sometimes noticeably."
                    ),
                    QAItem(
                        question: "What is the difference between hormonal imbalance and irregular periods?",
                        answer: "Hormonal imbalance means your body has too much or too little of a hormone like estrogen or progesterone. \n\nThis can be triggered by stress, diet, or medical conditions. Irregular periods, on the other hand, happen when your cycle doesn’t follow a predictable pattern. If things seem off, it’s always good to check in with a doctor."
                    ),
                    QAItem(
                        question: "What does it mean if my period blood is pink?",
                        answer: "Pink period blood often means it's mixed with cervical fluid. It could be spotting between cycles, ovulation bleeding, or even a sign of low estrogen levels. If it happens frequently, a doctor’s advice can help."
                    ),
                    QAItem(
                        question: "My periods are a weird color. What should I do?",
                        answer: "Your period’s color can range from bright red to dark brown—it’s all part of the cycle. But if you notice anything unusual, like grayish tones or a sudden drastic change, it might be worth checking in with a healthcare provider."
                    ),
                    QAItem(
                        question: "What are the small clots in my period?",
                        answer: "Period clots are completely normal! They’re just the uterus shedding its lining. As long as they’re small and occasional, there's nothing to worry about."
                    ),
                    QAItem(
                        question: "Why does period blood smell bad?",
                        answer: "Period blood itself doesn’t have an odor, but when it mixes with bacteria, it can develop a scent. \n\nKeeping good hygiene, like changing pads or tampons regularly, helps keep things fresh and comfortable."
                    )
                ]
            ),
            QuestionCategory(
                    name: "PCOS & PCOD",
                    items: [
                        QAItem(
                            question: "What is Polycystic Ovary Syndrome (PCOS)?",
                            answer: "PCOS is a hormonal condition where the ovaries may produce excess androgens (male hormones) and develop small fluid-filled sacs. \n\nIt can affect your cycle, skin, weight, and energy levels. The good news? Understanding it helps manage it."
                        ),
                        QAItem(
                            question: "Tell me about irregular period cycles.",
                            answer: "Irregular cycles can mean shorter than 21 days or longer than 35 days. They can be caused by stress, hormonal shifts, or underlying conditions like PCOS. If your cycle feels unpredictable, tracking it can help."
                        ),
                        QAItem(
                            question: "If the period lasts 3 days, does that mean a low chance of fertility?",
                            answer: "Not necessarily! Menstrual cycles are unique to each person. A 3-day period can be completely normal. Fertility depends on ovulation, cycle health, and hormone balance."
                        ),
                        QAItem(
                            question: "What treatment modalities are available for managing endometriosis-related menstrual symptoms?",
                            answer: "Managing endometriosis can involve hormonal therapy, pain management, or, in some cases, surgery. A tailored approach with a doctor ensures the best plan for you."
                        ),
                        QAItem(
                            question: "Can PCOS cause mood swings or anxiety?",
                            answer: "Yes! PCOS impacts hormones like estrogen and progesterone, which influence mood. Some experience anxiety or mood swings, but lifestyle changes and support can help."
                        ),
                        QAItem(
                            question: "What are the early signs of PCOS in teenagers?",
                            answer: "Early signs include irregular periods, acne, unexpected weight changes, and increased hair growth. Noticing these? A simple health check can bring clarity."
                        ),
                        QAItem(
                            question: "How does PCOS affect weight and metabolism?",
                            answer: "PCOS can make it easier to gain weight and harder to lose it due to insulin resistance. The key? Balanced nutrition, movement, and stress management—it’s about progress, not perfection."
                        ),
                        QAItem(
                            question: "Can someone have PCOS without cysts on their ovaries?",
                            answer: "Absolutely! PCOS is more about hormone imbalances than actual cysts. Some people with PCOS don’t have cysts, and some with ovarian cysts don’t have PCOS."
                        ),
                        QAItem(
                            question: "Why does PCOS cause excessive hair growth?",
                            answer: "PCOS can lead to increased levels of androgens (male hormones), which may cause extra hair growth on the face, chest, or back. It’s a common symptom, and there are ways to manage it."),
                        QAItem(
                            question: "Does birth control help with PCOS?",
                            answer: "Yes! Birth control can help regulate periods, reduce acne, and manage symptoms like excess hair growth. But it’s just one option—talking to a doctor can help find what works best for you."
                        ),
                        QAItem(
                            question: "What lifestyle changes can help manage PCOS symptoms?",
                            answer: "Small, consistent changes matter—balancing meals with protein and fiber, managing stress, getting enough sleep, and staying active can all support hormone balance."
                        ),
                        QAItem(
                            question: "Can PCOS go away on its own?",
                            answer: "PCOS doesn’t ‘go away,’ but its symptoms can be managed. The right approach—lifestyle, medical support, and self-care—can make a big difference."
                        ),
                        QAItem(
                            question: "What foods are good for managing PCOS?",
                            answer: "Think whole foods: leafy greens, lean proteins, fiber-rich carbs, and healthy fats. Keeping blood sugar stable is key, so pairing carbs with protein helps."
                        ),
                        QAItem(
                            question: "How does PCOS affect acne and skin health?",
                            answer: "Hormonal imbalances can lead to breakouts, especially along the jawline. Managing stress, skincare, and balanced nutrition can help keep your skin happy."
                        ),
                        QAItem(
                            question: "What’s the difference between PCOS and PCOD?",
                            answer: "PCOS is a hormonal disorder that affects metabolism and ovulation, while PCOD (Polycystic Ovarian Disorder) is a broader term for cyst formation. PCOS has more systemic effects on health."),
                        QAItem(
                            question: "What is Polycystic Ovarian Disorder (PCOD)?",
                            answer: "PCOD is when the ovaries develop multiple small follicles that can lead to irregular periods. Unlike PCOS, it doesn’t always cause major hormonal imbalances and is often managed with lifestyle changes."
                        ),
                        QAItem(
                            question: "Can PCOD cause weight gain?",
                            answer: "PCOD doesn’t always lead to weight gain, but it can impact metabolism slightly. A balanced diet and movement can help keep things in check."
                        ),
                        QAItem(
                            question: "Does PCOD affect fertility?",
                            answer: "It can, but not always. Many people with PCOD conceive naturally. Tracking ovulation and maintaining a healthy lifestyle can support fertility."
                        ),
                        QAItem(
                            question: "Can stress make PCOD worse?",
                            answer: "Yes! Stress affects cortisol levels, which in turn can disrupt ovulation and menstrual cycles. Finding ways to relax can help balance your cycle."
                        ),
                        QAItem(
                            question: "Do all women with PCOD have irregular periods?",
                            answer: "Not necessarily. Some may have regular but lighter periods, while others may experience irregular cycles. Every body is different."
                        ),
                        QAItem(
                            question: "Is PCOD reversible?",
                            answer: "PCOD can be managed effectively with diet, exercise, and lifestyle changes. Over time, symptoms can improve, but keeping a healthy routine is key."
                        ),
                        QAItem(
                            question: "Can PCOD cause skin issues like acne?",
                            answer: "Yes! Hormonal imbalances from PCOD can lead to acne, especially on the jawline and chin. Good skincare and a balanced diet can help."
                        ),
                        QAItem(
                            question: "What foods should I avoid if I have PCOD?",
                            answer: "Minimizing processed foods, excess sugar, and dairy may help some people manage symptoms. Think whole foods, fiber, and healthy fats!"
                        ),
                        QAItem(
                            question: "How can I naturally regulate my periods with PCOD?",
                            answer: "Regular movement, stress management, and balanced nutrition can support more predictable cycles. Small changes add up!"
                        ),
                        QAItem(
                            question: "Does PCOD lead to excessive hair growth like PCOS?",
                            answer: "PCOD usually doesn’t cause excessive hair growth as PCOS does, but some hormonal fluctuations can lead to mild changes."
                        ),
                        QAItem(
                            question: "Can exercise help with PCOD?",
                            answer: "Absolutely! Movement improves insulin sensitivity, supports hormone balance, and helps regulate cycles. It doesn’t have to be intense—find what you enjoy!"
                        ),
                        QAItem(
                            question: "What role does insulin resistance play in PCOD?",
                            answer: "Unlike PCOS, insulin resistance is not a major factor in PCOD. However, maintaining stable blood sugar can still support hormonal balance."
                        ),
                        QAItem(
                            question: "Do I need medication for PCOD?",
                            answer: "Not always! Many people manage PCOD with lifestyle changes alone. If symptoms persist, a doctor can help find the best approach."
                        ),
                    ]
                ),
            QuestionCategory(
                    name: "UTI & Infections",
                    items: [
                        QAItem(
                            question: "Can I get a urine infection if I am on my periods?",
                            answer: "Yes, but not because of your period itself. Menstrual hygiene plays a big role—changing pads or tampons regularly and staying hydrated helps keep infections away."
                        ),
                        QAItem(
                            question: "Why do I feel itchy during my periods?",
                            answer: "Itching during periods can be due to dryness, irritation from pads, or even mild infections. Switching to breathable cotton underwear and fragrance-free products can help."
                        ),
                        QAItem(
                            question: "What is a Urinary Tract Infection (UTI)?",
                            answer: "A UTI happens when bacteria enter the urinary tract, causing symptoms like burning while peeing, frequent urges, or cloudy urine. It’s common and treatable!"),
                        QAItem(
                            question: "How do I know if I have a UTI?",
                            answer: "If peeing feels like fire, your lower belly aches, or you feel the need to go constantly—those could be signs of a UTI. Drinking water and seeing a doctor early can help."
                        ),
                        QAItem(
                            question: "Can poor menstrual hygiene cause infections?", 
                            answer: "Yes! Changing pads or tampons every 4-6 hours, wiping front to back, and staying dry help prevent bacterial growth and infections."
                        ),
                        QAItem(
                            question: "Why does my urine smell strong during my period?",
                            answer: "Period blood itself doesn’t smell, but when it mixes with natural bacteria, it can create an odor. Staying hydrated and practicing good hygiene helps."
                        ),
                        QAItem(
                            question: "Is it normal to feel a burning sensation while urinating on my period?",
                            answer: "Burning while urinating isn’t a normal period symptom—it could be a UTI, irritation, or even a mild infection. A doctor’s advice can help if it persists."
                        ),
                        QAItem(
                            question: "Can using pads or tampons cause infections?", 
                            answer: "They don’t directly cause infections, but not changing them often enough can trap bacteria and moisture, increasing the risk."
                        ),
                        QAItem(
                            question: "How can I prevent UTIs naturally?",
                            answer: "Simple habits make a big difference! Drink plenty of water, don’t hold your pee, wipe front to back, and urinate after intimacy to flush out bacteria."
                        ),
                        QAItem(
                            question: "What’s the difference between a UTI and a yeast infection?",
                            answer: "UTIs affect the urinary tract, causing pain while peeing. Yeast infections cause itching, thick discharge, and irritation in the vaginal area."
                        ),
                        QAItem(
                            question: "Why do yeast infections happen after my period?",
                            answer: "Hormonal shifts during your cycle can disrupt vaginal pH, making it easier for yeast to grow. Probiotics and breathable fabrics can help."
                        ),
                        QAItem(
                            question: "Can holding pee for too long cause an infection?",
                            answer: "Yes! Holding it too long lets bacteria multiply in the bladder, increasing the risk of UTIs. Listen to your body and go when you need to."
                        ),
                        QAItem(
                            question: "What foods help prevent UTIs?",
                            answer: "Cranberries, blueberries, and probiotic-rich foods like yogurt help keep the urinary tract healthy and balanced."
                        ),
                        QAItem(
                            question: "How do I keep my vaginal area clean during periods?",
                            answer: "Less is more—warm water is enough! Avoid scented products, wear breathable underwear, and change menstrual products regularly."
                        ),
                        QAItem(
                            question: "Does drinking more water help prevent infections?",
                            answer: "Yes! Staying hydrated helps flush out bacteria, keeping your urinary and vaginal health in check."
                        ),
                    ]
                ),
            QuestionCategory(
                    name: "Menstrual Hygiene & Products",
                    items: [
                        QAItem(
                            question: "What are period panties?",
                            answer: "Period panties are leak-proof, reusable underwear designed to absorb menstrual flow. Think of them as a backup for pads or tampons—or even a standalone option for lighter days."
                        ),
                        QAItem(
                            question: "What is the main advantage of reusable menstrual products?",
                            answer: "Sustainability meets savings. Reusable products like menstrual cups and cloth pads reduce waste, save money over time, and offer a comfortable, leak-free experience."
                        ),
                        QAItem(
                            question: "What is the main advantage of menstrual cups in terms of environmental sustainability?",
                            answer: "One cup, years of impact. Unlike disposables, a single menstrual cup can last up to 10 years, drastically cutting down on plastic waste and landfill buildup."
                        ),
                        QAItem(
                            question: "How do eco-friendly menstrual products contribute to reducing waste in landfills?",
                            answer: "Every pad and tampon adds up. By choosing reusable products, you help divert thousands of disposables from landfills, making a small switch with a big environmental impact."
                        ),
                        QAItem(
                            question: "How often should I change my pad or tampon?",
                            answer: "Every 4-6 hours is ideal. For heavier flows, you might need to change more often. Staying fresh means staying comfortable."
                        ),
                        QAItem(
                            question: "Are menstrual cups safe?",
                            answer: "Yes! They’re made from medical-grade silicone, creating a leak-proof seal without disrupting your body’s natural balance. Plus, no more dryness or irritation."
                        ),
                        QAItem(
                            question: "Do menstrual cups hurt?",
                            answer: "Not at all! It’s all about the right fold and placement. With practice, you won’t even feel it—just like wearing your favorite comfy sneakers."
                        ),
                        QAItem(
                            question: "Can I swim while using a menstrual cup?",
                            answer: "Absolutely! Menstrual cups create a secure seal, so no leaks, no worries. Dive in, swim, and enjoy."
                        ),
                        QAItem(
                            question: "What’s the best way to clean a menstrual cup?",
                            answer: "Rinse with warm water and mild soap between uses, and boil for a few minutes at the end of each cycle. Clean, simple, and ready for next time."
                        ),
                        QAItem(
                            question: "What are the benefits of organic cotton pads and tampons?",
                            answer: "Gentle on you, gentle on the planet. Organic products skip the chemicals, dyes, and synthetic fibers—so they’re better for your body and biodegrade faster."
                        ),
                        QAItem(
                            question: "Are period tracking apps useful?",
                            answer: "Absolutely! They help you predict your cycle, track symptoms, and even notice patterns over time. Knowledge is power, and your cycle shouldn’t be a mystery."
                        ),
                        QAItem(
                            question: "Do scented pads or tampons cause irritation?",
                            answer: "They can! Fragrances and synthetic chemicals may disrupt your body’s natural balance, so unscented, breathable options are always a safer choice."
                        ),
                        QAItem(
                            question: "What’s the most eco-friendly menstrual product?",
                            answer: "Menstrual cups, cloth pads, and period panties lead the way. They’re reusable, reduce waste, and are kind to both your body and the planet."
                        ),
                    ]
                )
        ]

    }
    
//    func loadQAData() {
//        let fileName = "menstrual_awareness"
//        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
//            print("File not found: \(fileName).csv")
//            return
//        }
//        
//        do {
//            let fileURL = URL(fileURLWithPath: path)
//            let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
//            
//            // Parse CSV content manually
//            var tempDict: [String: String] = [:]
//            let rows = fileContent.components(separatedBy: .newlines)
//            
//            for row in rows {
//                let columns = row.components(separatedBy: ",")
//                if columns.count >= 2 {
//                    let question = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
//                    let answer = columns[1...].joined(separator: ",").trimmingCharacters(in: .whitespacesAndNewlines)
//                    tempDict[question] = answer
//                }
//            }
//            
//            self.qaDictionary = tempDict
//            print("QA Data Loaded Successfully")
//            print("Loaded \(qaDictionary.count) questions and answers.")
//            
//        } catch {
//            print("Error loading file: \(error)")
//        }
//    }


    
      
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
    
    func getAllTitlesOfStories() -> [String] {
        stories.map { $0.title }
    }
    
    func getTitleOfStory(of index: Int) -> String {
        getAllStories()[index].title
    }
    
    func getAllImagesOfStories() -> [String] {
        stories.map { $0.storyImage }
    }
    
    func getImageOfStory(at index: Int) -> String {
        getAllStories()[index].storyImage
    }
    
    func getMCQScene(ofStoryIndex index: Int) -> MCQScene {
        stories[index].mcqScene
    }
    
    func getNumberOfDescriptionsInScene(ofStoryIndex index: Int, sceneIndex: Int) -> Int {
        stories[index].storyScenes[sceneIndex].descriptions.count
    }
    
    //MARK: - Svaraa's Talk functions
    func getAllPCODQuestions() -> [String] {
        pcodDetectQuestions
    }
    
    func getAllPCOSQuestions() -> [String] {
        pcosDetectQuestions
    }
    
    func getQADictionary() -> [String: String] {
        qaDictionary
    }
    
    //MARK: - Svaraa's Logs functions
    
    func getPCOSCheckList() -> CheckList? {
        checkLists.filter { $0.name == "PCOS" }.first
    }
    
    func toggleCheckItem(checkListIndex: Int, category: ChecklistCategory, itemIndex: Int) {
        guard checkListIndex < checkLists.count else { return }

        switch category {
        case .morning:
            guard itemIndex < checkLists[checkListIndex].morningList.count else { return }
            checkLists[checkListIndex].morningList[itemIndex].isChecked.toggle()
        case .afternoon:
            guard itemIndex < checkLists[checkListIndex].afternoonList.count else { return }
            checkLists[checkListIndex].afternoonList[itemIndex].isChecked.toggle()
        case .evening:
            guard itemIndex < checkLists[checkListIndex].eveningList.count else { return }
            checkLists[checkListIndex].eveningList[itemIndex].isChecked.toggle()
        case .night:
            guard itemIndex < checkLists[checkListIndex].nightList.count else { return }
            checkLists[checkListIndex].nightList[itemIndex].isChecked.toggle()
        case .common:
            guard itemIndex < checkLists[checkListIndex].commonList.count else { return }
            checkLists[checkListIndex].commonList[itemIndex].isChecked.toggle()
        }

        saveCheckLists() // Save the state after toggling
    }
    
    func saveCheckLists() {
        if let encodedData = try? JSONEncoder().encode(checkLists) {
            UserDefaults.standard.set(encodedData, forKey: "savedCheckLists")
        }
    }


    func loadCheckLists() {
        if let savedData = UserDefaults.standard.data(forKey: "savedCheckLists"),
           let decodedCheckLists = try? JSONDecoder().decode([CheckList].self, from: savedData) {
            checkLists = decodedCheckLists
        }
    }


    func getCheckLists() -> [CheckList] {
        return checkLists
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
