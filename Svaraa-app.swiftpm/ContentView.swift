import SwiftUI

struct ContentView: View {
    var body: some View {
//        Uncomment the code to 
        
        if DataController.shared.getUserAge() < Int.max {
            MainTabView()
        } else {
            OnboardingView()
        }
//        OnboardingView()
    }
}
