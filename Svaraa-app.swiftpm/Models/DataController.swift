import Foundation


//Creating Singleton class
@MainActor
class DataController: ObservableObject {
    private var user: User =
    User(
        name: UserDefaults.standard.string(forKey: "userName") ?? "User",
        age: UserDefaults.standard.integer(forKey: "userAge") == 0 ? Int.max : UserDefaults.standard.integer(forKey: "userAge")
    )
    
    private var questionCategories: [QuestionCategory] = []
    
    private var stories: [Story] = []
    
    @Published var checkLists: [CheckList] = [] {
            didSet {
                saveCheckLists()
            }
        }
    
    static let shared = DataController()
    
    private init() {
        loadData()
        loadCheckLists()
        checkAndResetIfNewDay()
        loadQA()
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
                            "She was so busy that she barely noticed small changes in her body."
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
                        backgroundImageName: "bedroom-bg",
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
                        backgroundImageName: "bedroom-bg",
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
        
        
        
    }
    
    func loadQA() {
        questionCategories = [
            QuestionCategory (
                name: "Your Cycle, Explained",
                items: [
                    QAItem(
                        question: "What should I know about my first period?",
                        answer: "Your first period is your body’s way of saying, \"You're growing beautifully.\" It might bring surprises—cramps, mood swings, or a \"Wait, what?!\" moment—but don’t worry, you’ve got this. \n\nStay prepared, listen to your body (hello, snacks and cozy blankets!), and remember—every cycle is unique, just like you. \n\nIf you’re unsure, talk to someone you trust. You’re not alone."
                    ),QAItem(
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
                    name: "Apple HealthKit: Smarter Tracking",
                    items: [
                        QAItem(question: "How can I track my period using Apple HealthKit?", answer: "Seamlessly. Open the Health app, \n\nTap ‘Browse’ > ‘Cycle Tracking,’ and log your period dates. \n\nApple HealthKit does the rest, providing insights over time."),
                        QAItem(question: "What cycle data does the Apple Watch collect?", answer: "Apple Watch can track body temperature, heart rate, and even sleep changes—helping you see how your cycle influences overall health."),
                        QAItem(question: "How accurate is period tracking with smart devices?", answer: "With consistent logging, period tracking apps can predict cycles with high accuracy. Apple HealthKit even refines predictions based on real-time body signals."),
                        QAItem(question: "Can my Apple Watch predict my next period?", answer: "Yes! With cycle data and temperature tracking, Apple Watch offers smarter predictions over time, helping you plan ahead with confidence."),
                        QAItem(question: "How do I enable menstrual tracking in Apple Health?", answer: "Simply go to the Health app, tap ‘Cycle Tracking,’ and start logging. You can enable reminders and sync with Apple Watch for seamless tracking."),
                        QAItem(question: "What are the benefits of tracking my cycle using an app?", answer: "Understanding your body’s rhythm helps manage symptoms, predict fertile windows, and even spot irregularities early—so you're always in sync."),
                        QAItem(question: "How does temperature tracking help in predicting ovulation?", answer: "Apple Watch measures wrist temperature while you sleep, detecting small shifts that indicate ovulation. A smarter way to track fertility."),
                        QAItem(question: "Can fitness trackers like Fitbit or Garmin track my period?", answer: "Yes, many wearables offer cycle tracking, but Apple HealthKit integrates it with your overall wellness—making it more than just a calendar."),
                        QAItem(question: "Does tracking my period help with irregular cycles?", answer: "Absolutely! Noticing patterns (or a lack of them) helps you discuss concerns with a doctor, making period tracking a key part of health awareness."),
                        QAItem(question: "Can I use HealthKit data to track PCOS symptoms?", answer: "Yes! Logging cycle length, symptoms, and body temperature can help identify irregularities. While Apple HealthKit doesn’t diagnose, it gives you valuable insights."),
                        QAItem(question: "How secure is my cycle tracking data in Apple Health?", answer: "Your health data stays yours. Apple HealthKit is designed with privacy in mind—your cycle data is encrypted and never shared without your consent."),
                        QAItem(question: "Can I get notifications about my cycle on my Apple Watch?", answer: "Yes! Enable cycle tracking notifications in the Health app to get gentle reminders about upcoming periods and fertile windows."),
                        QAItem(question: "Does tracking my period help with PMS symptoms?", answer: "Knowing when PMS is coming helps you plan self-care—whether it’s extra hydration, movement, or just some well-timed chocolate."),
                    ]
                ),
            QuestionCategory(
                name: "PCOS & PCOD, Simplified",
                items: [
                    QAItem(
                        question: "What is Polycystic Ovary Syndrome (PCOS)?",
                        answer: "PCOS is a hormonal imbalance that can lead to irregular cycles, acne, weight changes, and excess hair growth.\n\nThe good news? It’s manageable—with the right approach, you can take control of your health."
                    ),
                    QAItem(
                        question: "Tell me about irregular period cycles.",
                        answer: "Your cycle should follow a rhythm. If it's shorter than 21 days, longer than 35, or unpredictable, stress or hormonal shifts might be at play. \n\nTracking it helps you spot patterns and stay informed."
                    ),
                    QAItem(
                        question: "If my period lasts only 3 days, does that mean I have low fertility?",
                        answer: "Not at all! Every body is unique. A 3-day period can be completely normal. What matters most? Ovulation and overall cycle health."
                    ),
                    QAItem(
                        question: "What are the early signs of PCOS in teenagers?",
                        answer: "Irregular periods, stubborn acne, weight fluctuations, and excess hair growth. Noticing these? A quick health check can bring clarity."
                    ),
                    QAItem(
                        question: "Can PCOS cause mood swings or anxiety?",
                        answer: "Yes! Hormonal shifts in PCOS can impact mood, leading to anxiety or mood swings. The key? Balanced nutrition, movement, and stress management can help bring stability."
                    ),
                    QAItem(
                        question: "How does PCOS affect weight and metabolism?",
                        answer: "PCOS can make weight management tricky due to insulin resistance. The secret? Small, consistent lifestyle changes—movement, mindful eating, and stress reduction—make all the difference."
                    ),
                    QAItem(
                        question: "Can someone have PCOS without cysts on their ovaries?",
                        answer: "Absolutely! PCOS is about hormonal imbalances, not just cysts. Some people with PCOS don’t have cysts, and some with ovarian cysts don’t have PCOS."
                    ),
                    QAItem(
                        question: "Why does PCOS cause excessive hair growth?",
                        answer: "Elevated androgens (male hormones) can trigger extra hair growth on the face, chest, or back. The good news? Treatment options exist to help manage this."
                    ),
                    QAItem(
                        question: "Does birth control help with PCOS?",
                        answer: "Yes! It can help regulate cycles, clear acne, and manage symptoms like excess hair growth. The best part? There’s no one-size-fits-all—your doctor can help find what works for you."
                    ),
                    QAItem(
                        question: "What lifestyle changes help manage PCOS symptoms?",
                        answer: "Consistency is key! A balanced diet, quality sleep, and daily movement help regulate hormones and keep symptoms in check."
                    ),
                    QAItem(
                        question: "Can PCOS go away on its own?",
                        answer: "PCOS doesn’t ‘go away,’ but its symptoms can be managed. With the right care, you can feel more in control of your health."
                    ),
                    QAItem(
                        question: "What foods are good for managing PCOS?",
                        answer: "Think whole foods—leafy greens, lean proteins, fiber-rich carbs, and healthy fats. Keeping blood sugar stable is key, so pairing carbs with protein helps."
                    ),
                    QAItem(
                        question: "How does PCOS affect acne and skin health?",
                        answer: "Hormonal imbalances can lead to stubborn breakouts, especially around the jawline. The fix? Hydration, a simple skincare routine, and balancing hormones through lifestyle choices."
                    ),
                    QAItem(
                        question: "What’s the difference between PCOS and PCOD?",
                        answer: "PCOS is a hormonal disorder that affects metabolism and ovulation, while PCOD (Polycystic Ovarian Disorder) primarily refers to ovarian cyst formation. PCOS tends to have a broader impact on health."
                    ),
                    QAItem(
                        question: "What is Polycystic Ovarian Disorder (PCOD)?",
                        answer: "PCOD occurs when the ovaries develop multiple small follicles, leading to irregular periods. The best part? Unlike PCOS, it’s often managed effectively through simple lifestyle changes."
                    ),
                    QAItem(
                        question: "Can PCOD cause weight gain?",
                        answer: "PCOD doesn’t always lead to weight gain, but metabolism can slow down slightly. A balanced diet and movement help keep things in check."
                    ),
                    QAItem(
                        question: "Does PCOD affect fertility?",
                        answer: "Not always. Many with PCOD conceive naturally. Tracking ovulation and maintaining a healthy routine can support fertility."
                    ),
                    QAItem(
                        question: "Can stress make PCOD worse?",
                        answer: "Yes! Stress disrupts hormone levels, which can throw off your cycle. Deep breathing, mindful movement, and sleep can help bring balance."
                    ),
                    QAItem(
                        question: "Do all women with PCOD have irregular periods?",
                        answer: "Not necessarily. Some have regular but lighter periods, while others experience unpredictable cycles. Every body is different."
                    ),
                    QAItem(
                        question: "Is PCOD reversible?",
                        answer: "PCOD symptoms can improve significantly with diet, movement, and stress management. Small, consistent changes make a big impact!"
                    ),
                    QAItem(
                        question: "Can PCOD cause skin issues like acne?",
                        answer: "Yes! Hormonal fluctuations can lead to acne, especially on the jawline and chin. A good skincare routine and hormone balance can help."
                    ),
                    QAItem(
                        question: "What foods should I avoid if I have PCOD?",
                        answer: "Processed foods, excess sugar, and dairy can sometimes trigger symptoms. Think whole foods, fiber, and healthy fats instead!"
                    ),
                    QAItem(
                        question: "How can I naturally regulate my periods with PCOD?",
                        answer: "Regular movement, stress management, and balanced nutrition help create a more predictable cycle. Small changes, big difference!"
                    ),
                    QAItem(
                        question: "Does PCOD lead to excessive hair growth like PCOS?",
                        answer: "PCOD usually doesn’t trigger excessive hair growth like PCOS, but mild fluctuations in hormones can lead to subtle changes."
                    ),
                    QAItem(
                        question: "Can exercise help with PCOD?",
                        answer: "Absolutely! Movement supports hormone balance, improves insulin sensitivity, and helps regulate cycles. It’s about finding what feels good for you."
                    ),
                    QAItem(
                        question: "What role does insulin resistance play in PCOD?",
                        answer: "Unlike PCOS, insulin resistance isn’t a major factor in PCOD. However, stabilizing blood sugar through balanced meals still supports hormonal health."
                    ),
                    QAItem(
                        question: "Do I need medication for PCOD?",
                        answer: "Not always! Many manage PCOD with lifestyle changes alone. If symptoms persist, a doctor can help explore options tailored to you."
                    )
                ]
            ),
            QuestionCategory(
                    name: "UTIs & Infections: Stay Ahead",
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
                    name: "Better Period Care",
                    items: [
                        QAItem(
                            question: "How to use a tampon?",
                            answer: "Think of it like learning to tie your shoelaces—tricky at first, easy with practice. \n\nWash your hands, get comfy, angle the tampon slightly toward your lower back, and gently insert. If it feels off, adjust. Remove the applicator, leave the string, and change it every 4–8 hours. You’ve got this!"
                        ),QAItem(
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
                ),
            QuestionCategory(
                    name: "Know the Signs",
                    items: [
                        QAItem(
                            question: "Could I have PCOS?",
                            answer: "If your periods are irregular, you’re noticing excess hair growth, unexplained weight changes, or persistent acne, PCOS might be a factor.\n\nTracking symptoms and checking with a doctor can help bring clarity."
                        ),
                        QAItem(
                            question: "Could I have PCOD?",
                            answer: "PCOD often presents with irregular periods and multiple small ovarian follicles. Unlike PCOS, it’s usually less severe and manageable with lifestyle changes.\n\nIf your cycle feels off, tracking patterns is the first step."
                        ),
                        QAItem(
                            question: "What are signs of hormonal imbalance?",
                            answer: "Sudden mood swings, extreme fatigue, unexpected weight gain, or acne that won’t budge? Your hormones might be asking for attention.\n\nA simple blood test can help uncover the cause."
                        ),
                        QAItem(
                            question: "Could I have endometriosis?",
                            answer: "If your cramps feel unbearable, periods are extremely heavy, or you experience pain during intimacy, endometriosis could be the reason.\n\nA doctor’s visit can provide answers and relief."
                        ),
                        QAItem(
                            question: "Could my period symptoms mean I have thyroid issues?",
                            answer: "A period that’s too light, too heavy, or missing altogether? Paired with fatigue, dry skin, or hair loss? Your thyroid might be out of sync.\n\nA quick test can help rule it out."
                        ),
                        QAItem(
                            question: "Could I have anemia from heavy periods?",
                            answer: "Feeling dizzy, weak, or constantly exhausted during or after your period? Heavy bleeding can deplete iron levels, leading to anemia.\n\nIron-rich foods and a check-in with a doctor can make all the difference."
                        ),
                        QAItem(
                            question: "Are my cramps normal or a sign of something more?",
                            answer: "Mild cramps? Normal. Pain that keeps you from daily life? Not normal.\n\nSevere cramps could indicate endometriosis, fibroids, or PCOS—tracking pain patterns helps uncover the cause."
                        ),
                        QAItem(
                            question: "What if my period has stopped suddenly?",
                            answer: "Missed a period (and you're not pregnant)? Stress, hormonal shifts, extreme exercise, or medical conditions could be the cause.\n\nIf it happens often, a health check can provide answers."
                        )
                    ]
                ),
            QuestionCategory(
                    name: "Symptoms & Solutions",
                    items: [
                        QAItem(question: "What are some nutrient-rich foods that support menstrual health?", answer: "Fuel your cycle with iron-rich spinach, magnesium-packed dark chocolate, and omega-3-rich nuts. Your body works hard—give it what it needs."),
                        QAItem(question: "What are some dietary strategies for managing common menstrual symptoms?", answer: "Small changes, big relief. Balance your plate with whole foods, fiber, and protein. Reduce salty, processed foods to keep bloating at bay."),
                        QAItem(question: "What should I do when I get cramps?", answer: "Heat, movement, and hydration. A warm compress, gentle stretching, or sipping ginger tea can ease the discomfort. Your body is adjusting—be kind to it."),
                        QAItem(question: "When should I see a doctor for cramps and pain?", answer: "If cramps stop you from living your day, last longer than normal, or don’t improve with home remedies, it’s worth checking in with a doctor."),
                        QAItem(question: "What is causing my Heavy Menstrual Bleeding?", answer: "Hormones, fibroids, or even stress could be at play. If you're soaking through pads quickly or feeling extra fatigued, it's time to seek guidance."),
                        QAItem(question: "How do symptoms vary throughout the cycle?", answer: "Your cycle is a rhythm, not a straight line. Energy may soar after your period, emotions may shift mid-cycle, and cravings or cramps might appear before your next flow."),
                        QAItem(question: "What role does hydration play in menstrual health?", answer: "Water helps everything flow smoothly—literally. Staying hydrated reduces bloating, fatigue, and headaches while keeping your body balanced."),
                        QAItem(question: "Why do I feel exhausted during my period?", answer: "Your body is losing iron, and hormones are shifting. Rest, fuel up on leafy greens, and listen to what your body needs."),
                        QAItem(question: "Is it normal to feel dizzy during my period?", answer: "A little lightheadedness can happen due to low iron or blood pressure shifts. But if it’s frequent or severe, checking with a doctor is a good call."),
                        QAItem(question: "Why do I get headaches before my period?", answer: "Hormonal drops before your period can trigger headaches. Staying hydrated, managing stress, and keeping blood sugar stable can help."),
                        QAItem(question: "Can my period cause nausea?", answer: "Yes, period-related nausea is common due to hormonal shifts and prostaglandins. Small, frequent meals and ginger tea can ease the queasiness."),
                        QAItem(question: "Why do my breasts hurt before my period?", answer: "Hormones cause fluid retention, making breasts feel sore. Wearing a supportive bra and reducing salty foods can help."),
                        QAItem(question: "Is it normal to feel emotional before my period?", answer: "Completely. Mood swings are linked to hormonal shifts. Gentle movement, fresh air, and balanced meals can help stabilize emotions."),
                        QAItem(question: "Why do I crave junk food before my period?", answer: "Your body is prepping for hormone changes, making carbs and sugar extra tempting. Balance cravings with nutrient-rich snacks."),
                        QAItem(question: "Can my period make my skin break out?", answer: "Yes, hormonal fluctuations can cause breakouts, especially around the jawline. A simple, gentle skincare routine keeps things under control."),
                    ]
                ),
            QuestionCategory(
                    name: "Breaking the Myths",
                    items: [
                        QAItem(question: "Is menstruation a taboo subject?", answer: "In many places, yes—but it shouldn’t be. Periods are a natural, biological process. Breaking the silence starts with open conversations."),
                        QAItem(question: "Why do some Indian mothers still tell their daughters to hide their period products?", answer: "Years of conditioning have made periods something to ‘conceal.’ But new generations are rewriting this narrative with openness and confidence."),
                        QAItem(question: "How can LGBTQ+ individuals access menstrual products without stigma?", answer: "Gender-neutral product packaging, inclusive restroom policies, and education help create a more accessible, stigma-free experience for all."),
                        QAItem(question: "How can LGBTQ+ organizations and community centers support menstrual health initiatives?", answer: "By recognizing that not all who menstruate identify as women. Inclusive education, gender-neutral product access, and safe spaces help all individuals manage their health."),
                        QAItem(question: "What role do menstrual taboos play in maintaining social order in certain cultures?", answer: "In some cultures, menstrual taboos stem from ancient beliefs about purity and impurity. While traditions shape societies, education helps rewrite the narrative."),
                        QAItem(question: "How does menstrual inequity impact girls' education in developing nations?", answer: "Lack of access to menstrual products and hygiene facilities forces many girls to miss school. When periods become a barrier, education and opportunity suffer."),
                        QAItem(question: "How did early menstrual product advertisements reflect societal attitudes towards menstruation?", answer: "Early ads avoided direct language, using ‘hygiene’ instead of ‘periods.’ Over time, marketing evolved—now, brands embrace transparency and empowerment."),
                        QAItem(question: "What were some cultural clashes that arose regarding menstrual practices during colonial rule?", answer: "Colonial rulers often dismissed indigenous menstrual practices, imposing Western norms. This led to clashes over beliefs, hygiene, and women’s autonomy."),
                        QAItem(question: "How can sexual health education address menstrual equity and social justice?", answer: "By making periods part of the conversation. Normalizing menstrual health in schools and communities ensures access, dignity, and informed choices for all."),
                        QAItem(question: "How does a father's attitude towards menstruation influence their daughters' perceptions of menstrual health?", answer: "Fathers who talk openly about periods help normalize them. A supportive dad can empower his daughter to embrace her cycle with confidence."),
                        QAItem(question: "How can fathers help reduce menstrual stigma and shame experienced by their daughters?", answer: "By learning, listening, and normalizing. Simple acts—like buying menstrual products or discussing periods casually—break outdated taboos."),
                        QAItem(question: "How do workplace policies regarding menstrual leave vary across different countries?", answer: "Some countries, like Japan and Indonesia, offer menstrual leave, while others barely acknowledge period pain. The conversation on workplace equity is growing."),
                        QAItem(question: "Why are menstruating women still banned from temples in parts of India?", answer: "This belief ties back to purity myths. But times are changing—activists and communities are challenging these outdated restrictions."),
                        QAItem(question: "Why do some Indian families still avoid discussing periods?", answer: "Generations of silence have made periods a ‘women’s issue.’ But with education and awareness, open discussions are finally becoming the norm."),
                        QAItem(question: "Why do some cultures believe menstruating women shouldn't cook or touch food?", answer: "These myths stem from historical misconceptions. Science says otherwise—menstruation doesn’t affect food or energy in any way."),
                        QAItem(question: "How can schools in India improve menstrual health awareness?", answer: "By introducing period education early, providing free products, and training teachers to create safe, stigma-free spaces."),
                        QAItem(question: "How does social media impact menstrual stigma?", answer: "Social media is both a myth-buster and an amplifier of stigma. More open discussions are breaking taboos, one post at a time."),
                        QAItem(question: "What’s the impact of pink tax on menstrual products?", answer: "Some countries still tax pads and tampons as ‘luxury’ items, making them less accessible. Activists worldwide are pushing for tax-free period care."),
                    ]
                ),
            QuestionCategory(
                    name: "When to See a Doctor",
                    items: [
                        QAItem(question: "When should I see a doctor about my irregular periods?", answer: "If your cycle is constantly unpredictable, missing for months, or shorter than 21 days, it’s worth a check-in. Your period should work for you, not against you."),
                        QAItem(question: "How many days of period delay is normal before I should worry?", answer: "A few days’ delay is common due to stress, travel, or hormonal shifts. But if you miss multiple cycles or experience sudden changes, a doctor can help."),
                        QAItem(question: "What does it mean if my period suddenly stops?", answer: "Pregnancy, stress, excessive exercise, or hormone imbalances could be at play. If it’s been months with no period, getting checked is a good idea."),
                        QAItem(question: "When should I be concerned about heavy menstrual bleeding?", answer: "If you’re soaking through pads every 1-2 hours, passing large clots, or feeling weak and lightheaded, heavy bleeding isn’t just inconvenient—it’s a sign to seek medical advice."),
                        QAItem(question: "How do I know if my period cramps are abnormal?", answer: "Mild cramps are normal, but if pain keeps you from school, work, or daily activities—even with pain relief—it’s time to explore underlying causes."),
                        QAItem(question: "Is spotting between periods a sign of a serious issue?", answer: "Occasional light spotting can be normal, but if it’s frequent, heavy, or happens after intimacy, it’s best to check in with a doctor."),
                        QAItem(question: "Should I see a doctor if my periods are less than 21 days apart?", answer: "Yes! Frequent cycles could indicate hormonal imbalances or other underlying conditions that need attention."),
                        QAItem(question: "How can I tell if my discharge is normal or a sign of infection?", answer: "Healthy discharge is clear or white with a mild scent. If it's thick, greenish, has a strong odor, or comes with itching, it's time to check in."),
                        QAItem(question: "What symptoms of PCOS or PCOD should I watch out for?", answer: "Irregular cycles, acne, unexplained weight changes, and excess hair growth can be signs. If something feels off, tracking symptoms helps."),
                        QAItem(question: "When should I get tested for hormonal imbalances?", answer: "If you’re dealing with irregular periods, persistent acne, mood swings, or extreme fatigue, testing your hormones can offer answers."),
                        QAItem(question: "What are the signs of anemia due to heavy periods?", answer: "Feeling constantly tired, dizzy, pale, or short of breath? These could be signs of iron deficiency caused by heavy bleeding."),
                        QAItem(question: "How do I know if I have endometriosis?", answer: "Severe cramps, pain during intimacy, heavy bleeding, or trouble with digestion during your cycle might indicate endometriosis. A doctor can help diagnose it."),
                        QAItem(question: "Why do I experience dizziness or fainting during my period?", answer: "Low blood pressure, anemia, or sudden hormonal shifts can cause dizziness. If it’s frequent or extreme, getting checked is a good call."),
                        QAItem(question: "Why do I feel nauseous or have digestive issues during my period?", answer: "Hormones can slow digestion, leading to nausea, bloating, or even period-related diarrhea. If it's severe, a doctor can help."),
                        QAItem(question: "When should I see a doctor about period-related migraines?", answer: "If headaches are intense, happen every cycle, or come with vision issues, period-related migraines could be the cause—and treatment options exist."),
                        QAItem(question: "Can birth control affect my period symptoms?", answer: "Yes! It can lighten periods, ease cramps, or regulate cycles—but it can also cause spotting or changes. A doctor can help find the right fit for you."),
                        QAItem(question: "What does it mean if my periods are extremely painful?", answer: "Pain that interrupts your life isn’t normal. Conditions like endometriosis, fibroids, or hormonal imbalances could be the cause—checking with a doctor helps."),
                        QAItem(question: "Could stress be making my periods irregular?", answer: "Absolutely. Stress affects hormones, which can delay or even skip cycles. Finding ways to relax can help bring your cycle back on track."),
                    ]
                ),
            QuestionCategory(
                    name: "The Little Things That Matter",
                    items: [
                        QAItem(
                            question: "How does my hair change during periods?",
                            answer: "Ever had a great hair day right before your period? That’s estrogen at work. But during your period, oil production shifts, making hair feel drier or greasier. A little extra care goes a long way!"
                        ),
                        QAItem(
                            question: "How does my menstrual cycle affect my mood?",
                            answer: "Your cycle is a wave of hormonal changes. Some days, you’ll feel energized and social; others, a little more reflective. Knowing your cycle means understanding yourself better."
                        ),
                        QAItem(
                            question: "Is it true that menstruating individuals should avoid physical activity during their period?",
                            answer: "Nope! Movement can actually help with cramps, boost mood, and reduce bloating. Listen to your body—some days call for yoga, others for a rest day."
                        ),
                        QAItem(
                            question: "Why is syncing with your cycle important?",
                            answer: "Your cycle isn’t just about periods—it’s about energy, focus, and emotions. Syncing your workouts, work schedule, and self-care with your cycle helps you feel your best every day."
                        ),
                        QAItem(
                            question: "How does exercise affect my menstrual cycle?",
                            answer: "Movement supports hormone balance, reduces stress, and even helps regulate cycles. Just don’t overdo it—too much intensity can disrupt your cycle."
                        ),
                        QAItem(
                            question: "What should I do when I get cramps?",
                            answer: "Heat, hydration, and movement are your best friends. A warm compress, gentle stretching, or sipping ginger tea can make a world of difference."
                        ),
                        QAItem(
                            question: "At what age do periods stop?",
                            answer: "Menopause typically happens between 45-55 years old. But every body is different—genetics, lifestyle, and health all play a role in the timing."
                        )
                    ]
                )
            
        ]

    }
    
    func loadCheckLists() {
        if let savedData = UserDefaults.standard.data(forKey: "savedCheckLists"),
           let decodedCheckLists = try? JSONDecoder().decode([CheckList].self, from: savedData) {
            checkLists = decodedCheckLists
        } else {
            checkLists = [
                CheckList(
                    
                    name: "PCOS",
                    description: "Small, consistent habits create lasting change. \n\nThis daily checklist is designed to support hormonal balance, reduce inflammation, and boost metabolism—key factors in managing PCOS & PCOD. \n\nWith mindful nutrition, movement, and recovery, you can take control of your well-being, one check at a time. ",
                    
                    morningList: [
                        CheckListItem(name: "Drink warm lemon water / fenugreek seed water"),
                        CheckListItem(name: "Eat 5 soaked almonds + 2 walnuts + 1 tsp flaxseeds"),
                        CheckListItem(name: "Have a high-protein breakfast (Besan chilla / Sprouts / Ragi dosa / Eggs & toast / Paneer bhurji)"),
                        CheckListItem(name: "10 mins meditation or deep breathing"),
                        CheckListItem(name: "15–30 mins light exercise (walk, Surya Namaskar)")
                    ],
                    
                    afternoonList: [
                        CheckListItem(name: "Drink 1 glass coconut water / buttermilk"),
                        CheckListItem(name: "Eat 1 fruit (Guava, Papaya, Apple, Pomegranate, Berries)"),
                        CheckListItem(name: "Eat a balanced lunch (Dal + Millet/Brown Rice + Sabzi + Curd)"),
                        CheckListItem(name: "Take a 10-minute post-lunch walk")
                    ],
                    
                    eveningList: [
                        CheckListItem(name: "Eat a healthy snack (Roasted chana / Makhana / Peanut butter toast / Nuts & seeds)"),
                        CheckListItem(name: "30–45 mins of exercise (Yoga, Strength Training, Dance, Brisk Walk)"),
                        CheckListItem(name: "Drink 1 cup herbal tea (Spearmint, Cinnamon, Ginger-Turmeric)")
                    ],
                    
                    nightList: [
                        CheckListItem(name: "Eat a light dinner (Moong dal khichdi + Ghee / Soup + Sautéed Veggies / 1 Roti + Sabzi + Paneer/Tofu)"),
                        CheckListItem(name: "Drink 1 glass warm turmeric milk (Haldi + Almond milk)"),
                        CheckListItem(name: "5 mins deep breathing / gratitude journaling"),
                        CheckListItem(name: "Sleep for 7–9 hours")
                    ],
                    
                    commonList: [
                        CheckListItem(name: "Drink 2–3 liters of water"),
                        CheckListItem(name: "Take 5 deep breaths before meals"),
                        CheckListItem(name: "Avoid screens 30 mins before bed")
                    ]
                )
            ]
        }
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

    func getAllQuestionCategories() -> [QuestionCategory] {
        questionCategories
    }
    
    //MARK: - Svaraa's Logs functions
    
    func getPCOSCheckList() -> CheckList {
        checkLists.first ?? CheckList(name: "", description: "", morningList: [], afternoonList: [], eveningList: [], nightList: [], commonList: [])
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

        saveCheckLists()
    }
    
    func saveCheckLists() {
        if let encodedData = try? JSONEncoder().encode(checkLists) {
            UserDefaults.standard.set(encodedData, forKey: "savedCheckLists")
        }
    }


    func getCheckLists() -> [CheckList] {
        return checkLists
    }
    
    func getCheckListsProgress() -> Double {
        getPCOSCheckList().progress
    }

    
    private func checkAndResetIfNewDay() {
            let calendar = Calendar.current
            let lastSavedDate = UserDefaults.standard.object(forKey: "lastSavedDate") as? Date ?? Date()
            let currentDate = Date()
            
            if !calendar.isDate(lastSavedDate, inSameDayAs: currentDate) {
                resetAllCheckItems()
                UserDefaults.standard.set(currentDate, forKey: "lastSavedDate")
            }
        }
        
        private func resetAllCheckItems() {
            for i in checkLists.indices {
                resetListItems(&checkLists[i].morningList)
                resetListItems(&checkLists[i].afternoonList)
                resetListItems(&checkLists[i].eveningList)
                resetListItems(&checkLists[i].nightList)
                resetListItems(&checkLists[i].commonList)
            }
            saveCheckLists()
        }
        
        private func resetListItems(_ list: inout [CheckListItem]) {
            for j in list.indices {
                list[j].isChecked = false
            }
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
