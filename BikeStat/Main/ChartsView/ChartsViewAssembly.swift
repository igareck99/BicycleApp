import SwiftUI


enum ChartsViewAssembly {
    
    static func build() -> some View {
        let viewModel = ChartsViewModel()
        let view = ChartsView(viewModel: viewModel)
        return view
    }
}
