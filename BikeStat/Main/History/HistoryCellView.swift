import SwiftUI
import MapKit

// MARK: - HistoryCellView

struct HistoryCellView: View {
    
    @StateObject var viewModel: HistoryCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            Map(interactionModes: []) {
                Marker("", coordinate: viewModel.startPoint)
                Marker("", coordinate: viewModel.endPoint)
                if let route = viewModel.route {
                    MapPolyline(route)
                        .stroke(.green, lineWidth: 4)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 116)
            .cornerRadius(8)
            VStack(alignment: .leading,
                   spacing: 4) {
                Text("Минимальный пульс \(viewModel.template.minPulse)")
                Text("Средний пульс \(viewModel.template.middlePulse)")
                Text("Максимальный пульс \(viewModel.template.maxPulse)")
                Text("Пройденный путь \(Int(viewModel.template.distance)) метров")
                Text("Рассчетная сложность: \(viewModel.getCountableLevel())")
                Text("Средняя скорость: \(String(format: "%.2f", viewModel.template.middleSpeed) + "км / ч")")
                Text("Реальная сложность: \(viewModel.getLevel())")
                Text("Время поездки \(viewModel.template.duration.hourMinuteSecond)")
                Text("\(viewModel.template.rideTime)")
                    .frame(height: 44)
            }
        })
        .background(content: {
            Color.white
        })
        .frame(height: 120)
    }
    
}
