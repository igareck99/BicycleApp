import SwiftUI

enum TemplateViewAssembly {
    static func build(_ coordinator: MainCoordinatorProtocol) -> some View {
        let viewModel = TemplatesViewModel()
        let view = TemplatesView(viewModel: viewModel)
        viewModel.coordinator = coordinator
        return view
    }
}
