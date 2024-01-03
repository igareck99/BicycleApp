import SwiftUI

// MARK: - TemplateRideViewAssembly

enum TemplateRideViewAssembly {
    
    static func build(_ coordinator: MainCoordinatorProtocol,
                      template: TemplateRouteEnum) -> some View {
        let viewModel = TemplateRideViewModel(data: template,
                                              coordinator: coordinator)
        let view = TemplateRideView(viewModel: viewModel)
        return view
    }
}
