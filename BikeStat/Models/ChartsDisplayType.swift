import Foundation

// MARK: - ChartsDisplayType

enum ChartsDisplayType {
    case distance
    case speed
    case time
    
    var text: String {
        switch self {
        case .distance:
            return "Расстояние"
        case .speed:
            return "Скорость"
        case .time:
            return "Время"
        }
    }
}
