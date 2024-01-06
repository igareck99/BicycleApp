import SwiftUI


enum HistoryAssembly {
    
    static func build() -> some View {
        let viewModel = HistoryViewModel()
        let view = HistoryView(viewModel: viewModel)
        return view
    }
}
