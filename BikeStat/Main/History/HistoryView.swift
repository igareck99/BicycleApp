import SwiftUI


struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        List {
            Text("История")
            ForEach(viewModel.realmService.getRideData(), id: \.self) { value in
                HistoryCellView(viewModel: HistoryCellViewModel(template: value))
            }
        }
        .listStyle(.inset)
    }
}
