import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            if DataController.shared.getUserAge() < Int.max {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}
