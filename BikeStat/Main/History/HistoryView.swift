import SwiftUI


struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        List {
            Text("История")
        }
        .listStyle(.inset)
    }
}
