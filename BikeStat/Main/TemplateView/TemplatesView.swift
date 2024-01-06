import SwiftUI

struct TemplatesView: View {
    
    @StateObject var viewModel: TemplatesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.items, id: \.self) { value in
                let vm = HistoryTemplateCellViewModel(template: value)
                HistoryTemplateCellView(viewModel: vm)
                    .onTapGesture {
                        viewModel.coordinator?.onTemplateListView(value)
                    }
            }
        }
        .listStyle(.inset)
    }
}
