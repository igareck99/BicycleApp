import SwiftUI
import Charts

// MARK: - ChartsView

struct ChartsView: View {
    
    @StateObject var viewModel: ChartsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Статистика",
                   selection: $viewModel.selectedColorIndex, content: {
                Text(ChartsDisplayType.distance.text).tag(0)
                Text(ChartsDisplayType.speed.text).tag(1)
                Text(ChartsDisplayType.time.text).tag(2)
            })
            .pickerStyle(SegmentedPickerStyle())
            Chart {
                ForEach(viewModel.displayData) { item in
                    LineMark(
                        x: .value("Month", item.time.description),
                        y: .value("Temp", viewModel.getDisplayItem(item))
                    )
                }
            }
            .frame(height: 300)
            Spacer()
        }
    }
}
