import SwiftUI

// MARK: - TemplatesView

struct TemplatesView: View {
    
    // MARK: - Internal Properties

    @StateObject var viewModel: TemplatesViewModel
    
    // MARK: - Body

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
