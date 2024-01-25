import SwiftUI

// MARK: - HistoryView

struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.realmService.getRideData(), id: \.self) { value in
                HistoryCellView(viewModel: HistoryCellViewModel(template: value))
                    .frame(height: 350)
            }
        }
        .toolbar(.visible, for: .navigationBar)
        .listStyle(.inset)
        .navigationBarTitleDisplayMode(.inline)
    }
}
