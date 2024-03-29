import SwiftUI


enum MainViewAssembly {
    
    static func build(_ coordinator: MainCoordinatorProtocol) -> some View {
        let viewModel = MainViewModel()
        viewModel.coordinator = coordinator
        let view = MainView(viewModel: viewModel)
        return view
    }
}
