
import SwiftUI

struct SvaraaLogsView: View {
    var body: some View {
        NavigationStack {
            CheckListView()
                .navigationTitle("Daily Health Checklist")
        }
    }
}

#Preview {
    SvaraaLogsView()
}
