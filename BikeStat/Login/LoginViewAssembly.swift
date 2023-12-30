import SwiftUI

enum LoginViewAssembly {
    
    static func build(_ coordinator: MainCoordinatorProtocol) -> some View {
        let viewModel = LoginViewModel()
        viewModel.coordinator = coordinator
        let view = LoginView(viewModel: viewModel)
        return view
    }
}
