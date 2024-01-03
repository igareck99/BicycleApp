import Foundation

// MARK: - HistoryViewModel

final class TemplatesViewModel: ObservableObject {
    
    let items: [TemplateRouteEnum] = TemplateRouteEnum.allCases
    var coordinator: MainCoordinatorProtocol?
}
