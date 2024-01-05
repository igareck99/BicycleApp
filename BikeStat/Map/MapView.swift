import SwiftUI
import MapKit

struct MapView: View {

    @StateObject var viewModel: MapViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Map(interactionModes: [.all]) {
                Marker("", coordinate: viewModel.currentPosition)
            }
            .frame(height: UIScreen.main.bounds.width)
            labels
            Spacer()
        }
    }
    
    private var labels: some View {
        VStack(spacing: 12) {
            ButtonView(title: viewModel.isStart ? "Завершить поездку" : "Начать", colors: [.blue, .blue]) {
                if !viewModel.isStart {
                    viewModel.isStart.toggle()
                } else {
                    viewModel.computeResult()
                }
            }
            HStack(spacing: 16) {
                CurrencyView(width: (UIScreen.main.bounds.width - 48) / 2,
                             height: 44, backgroundColor: .white,
                             title: viewModel.timeString,
                             foregroundColor: .black)
                CurrencyView(width: (UIScreen.main.bounds.width - 48) / 2,
                             height: 44, backgroundColor: .white,
                             title: viewModel.speedString + " км/ч",
                             foregroundColor: .black)
            }
            CurrencyView(width: (UIScreen.main.bounds.width - 48) / 2,
                         height: 44, backgroundColor: .white,
                         title: String(Int(viewModel.distance)) + " метров",
                         foregroundColor: .black)
        }
    }
}
