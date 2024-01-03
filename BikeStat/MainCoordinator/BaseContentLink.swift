import Foundation

// MARK: - BaseContentLink

enum BaseContentLink: Hashable, Identifiable {
    
    case authState(_ coordinator: MainCoordinatorProtocol)
    case tabView(_ coordinator: MainCoordinatorProtocol)
    case mapView(_ coordinator: MainCoordinatorProtocol)
    case templateList(_ coordinator: MainCoordinatorProtocol)
    case templateRideView(_ coordinator: MainCoordinatorProtocol,
                          _ template: TemplateRouteEnum)
    
    // MARK: - Hashable, Identifiable
    
    var id: String {
        String(describing: self)
    }
    
    static func == (lhs: BaseContentLink, rhs: BaseContentLink) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
