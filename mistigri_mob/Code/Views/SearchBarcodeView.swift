//
//  SearchBarcodeView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 18/03/2025.
//

import SwiftUI

struct SearchBarcodeView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var searchText = ""
    @State private var showSuggestion = false
    @ObservedObject var checkoutVM: CheckoutViewModel = CheckoutViewModel()
    @FocusState private var isTextFieldFocused: Bool

    init(checkoutVM: CheckoutViewModel = CheckoutViewModel()) {
        self.checkoutVM = checkoutVM
    }

    var body: some View {
        VStack {
            HStack {
                TextField("SearchBarcode.Text.Title".localized, text: $searchText, onEditingChanged: { isEditing in
                    showSuggestion = searchText.isEmpty
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($isTextFieldFocused)
                .onSubmit {
                    if let firstBarcode = viewModel.filteredBarcodes(searchText: searchText).first {
                        searchText = firstBarcode.barcode_id
                        showSuggestion = false
                        checkoutVM.selectedBarcode = firstBarcode
                        isTextFieldFocused = false
                    }
                }

                if !searchText.isEmpty {
                    Button(action: clearSearch) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }

            if showSuggestion, let firstBarcode = viewModel.filteredBarcodes(searchText: searchText).first {
                Button("\(NSLocalizedString("Suggestion.Text.Title", comment: "")): \(firstBarcode.barcode_id)") {
                    searchText = firstBarcode.barcode_id
                    showSuggestion = false
                    checkoutVM.selectedBarcode = firstBarcode
                    isTextFieldFocused = false
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchAllBarcodes {}
        }
    }

    private func clearSearch() {
        searchText = ""
        isTextFieldFocused = false
    }

}
