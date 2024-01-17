import SwiftUI


struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.realmService.getRideData(), id: \.self) { value in
                    HistoryCellView(viewModel: HistoryCellViewModel(template: value))
                }
            }
        }
        .navigationTitle(Text("История"))
        .listStyle(.inset)
    }
}
