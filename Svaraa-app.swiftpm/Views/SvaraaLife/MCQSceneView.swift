import SwiftUI

struct MCQSceneView: View {
    var question: String?
    var options: [String]?
    var correctOptionIndex: Int?

    @State private var selectedOptionIndex: Int? = nil

    var body: some View {
        ZStack {
            VStack {
                Image("Svaraa_Confused")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            
            GradientView()
            
            VStack {
                // Question Box
                Text(question ?? "What should Svaraa do next?")
                    .font(.title3)
                    .bold()
                    .italic()
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.indigo.opacity(0.9))
                    .cornerRadius(12)
                    .frame(width: 350)
                
                Spacer()
                
                // Options placed at the bottom
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(options?.enumerated() ?? defaultOptions().enumerated()), id: \.element) { index, option in
                        Button(action: {
                            self.selectedOptionIndex = index
//                            self.showResult = true
                        }) {
                            Text(option)
                                .font(.body)
                                .padding()
                                .foregroundColor(.white)
                                .background(getOptionColor(index))
                                .cornerRadius(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
//                        .disabled(selectedOptionIndex != nil) // Disable after selection
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40) // Push options closer to the bottom
            }
            .frame(maxHeight: .infinity, alignment: .bottom) // Ensures bottom positioning
        }
    }

    // Function to highlight selected answer
    func getOptionColor(_ index: Int) -> Color {
        if let selected = selectedOptionIndex {
            if selected == index {
                return selected == correctOptionIndex ?? 1 ? Color.green.opacity(0.7) : Color.red.opacity(0.7)
            }
        }
        return Color.indigo.opacity(0.8) // Default color
    }

    // Default options in case no options are passed
    func defaultOptions() -> [String] {
        return [
            "Panic and hide it from everyone.",
            "Use tissue paper and hope it stops.",
            "Find an elder she trusts and ask for help.", // Correct answer
            "Ignore it and continue with the party."
        ]
    }
}

#Preview {
    MCQSceneView()
}
