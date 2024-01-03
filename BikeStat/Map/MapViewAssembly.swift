import SwiftUI

enum MapViewAssembly {
    
    static func build(_ coordinator: MainCoordinatorProtocol?) -> some View {
        let viewModel = MapViewModel()
        let view = MapView(viewModel: viewModel)
        viewModel.coordinator = coordinator
        return view
    }
}
