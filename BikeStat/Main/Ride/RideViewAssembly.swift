import SwiftUI

enum RideViewAssembly {
    
    static func build(_ coordinator: MainCoordinatorProtocol?) -> some View {
        let viewModel = RideViewModel()
        let view = RideView(viewModel: viewModel)
        viewModel.coordinator = coordinator
        return view
    }
}
