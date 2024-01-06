import Foundation
import RealmSwift
import MapKit

// MARK: - RideRealmData

class RideRealmData: Object {

    @Persisted(primaryKey: true) var _id: String
    @Persisted var distance: Double
    @Persisted var duration: TimeInterval
    @Persisted var middleSpeed: Double
    @Persisted var minPulse: Int
    @Persisted var middlePulse: Int
    @Persisted var maxPulse: Int
    @Persisted var countedDiff: Int
    @Persisted var realDiff: Int
    @Persisted var startLongtitude: Double
    @Persisted var startLattitude: Double
    @Persisted var endLongtitude: Double
    @Persisted var endLattitude: Double
}

// MARK: - RideData

struct RideData: Identifiable {

    var id = UUID().uuidString
    var distance: Double
    var duration: TimeInterval
    var middleSpeed: Double
    var minPulse: Int
    var middlePulse: Int
    var maxPulse: Int
    var countedDiff: Int
    var realDiff: Int
    var startLongtitued: Double
    var startLattitude: Double
    var endLongtitude: Double
    var endLattitude: Double
}
