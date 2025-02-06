import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("My name is Harshit")
                .font(.headline)
                .foregroundStyle(.pink, .black)
        }
        MainTabView()
    }
}
