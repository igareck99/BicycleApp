import Foundation

// MARK: - DisplayChartData

struct DisplayChartData: Identifiable {
    
    let id: UUID = UUID()
    let distance: Int
    let speed: Double
    let time: NSDate
    let dueation: TimeInterval
}
