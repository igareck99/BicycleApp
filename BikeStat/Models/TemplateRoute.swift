import Foundation
import MapKit

enum TemplateRouteEnum: CaseIterable {

    case one
    case two
    case three
    case four
    case five

    var startPoint: CLLocationCoordinate2D {
        switch self {
        case .one:
            return CLLocationCoordinate2D(latitude: 55.983430935961124,
                       longitude: 37.2113566650842)
        case .two:
            return CLLocationCoordinate2D(latitude: 56.008782317330954,
                       longitude: 37.20077904095952)
        case .three:
            return CLLocationCoordinate2D(latitude: 55.99743372402524,
                       longitude: 37.2367448923093)
        case .four:
            return CLLocationCoordinate2D(latitude: 55.96875954463992,
                       longitude: 37.13258993529138)
        case .five:
            return CLLocationCoordinate2D(latitude: 55.992898256553495,
                       longitude: 37.246977992128876)
        }
    }
    
    var endPoint: CLLocationCoordinate2D {
        switch self {
        case .one:
            return CLLocationCoordinate2D(latitude: 56.002617498267725,
                                          longitude: 37.209300444788134)
        case .two:
            return CLLocationCoordinate2D(latitude: 55.982586671195754,
                                          longitude: 37.175908864599265)
        case .three:
            return CLLocationCoordinate2D(latitude: 55.98163806860262,
                                          longitude: 37.24828499323545)
        case .four:
            return CLLocationCoordinate2D(latitude: 56.038462259893365,
                       longitude: 37.232012341263435)
        case .five:
            return CLLocationCoordinate2D(latitude: 55.93280657557389,
                       longitude: 37.195597450621214)
        }
    }
    
    var level: Int {
        switch self {
        case .one, .two:
            return 0
        case .three:
            return 1
        case .four, .five:
            return 2
        }
    }
}
