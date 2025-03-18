//
//  SearchSellerView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 17/03/2025.
//

import SwiftUI

struct SearchSellerView: View {
    @StateObject private var viewModel = SellerViewModel()
    @State private var searchText = ""
    @State private var showSuggestion = true
    @ObservedObject var depositViewModel: DepositViewModel = DepositViewModel()
    @FocusState private var isTextFieldFocused: Bool

    init(depositViewModel: DepositViewModel = DepositViewModel()) {
        self.depositViewModel = depositViewModel
    }

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                TextField("SearchSeller.Text.Title".localized, text: $searchText, onEditingChanged: { isEditing in
                    showSuggestion = searchText.isEmpty
                })
                .padding()
                .background(Color.CFFDC9A.opacity(0.35))
                .cornerRadius(8)
                .focused($isTextFieldFocused)
                .onSubmit {
                    if let firstSeller = viewModel.filteredSellers(searchText: searchText).first {
                        searchText = firstSeller.name
                        showSuggestion = false
                        depositViewModel.selectedSeller = firstSeller
                        isTextFieldFocused = false
                    }
                }

                if !searchText.isEmpty {
                    Button(action: clearSearch) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(hex: "fdd3d0"))
                    }
                    .padding(.trailing, 8)
                }
            }

            if showSuggestion, let firstSeller = viewModel.filteredSellers(searchText: searchText).first {
                Button("\(NSLocalizedString("Suggestion.Text.Title", comment: "")): \(firstSeller.name)") {
                    depositViewModel.selectedSeller = firstSeller
                    searchText = firstSeller.name
                    isTextFieldFocused = false
                    showSuggestion = false
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchAllSellers {}
        }
    }

    private func clearSearch() {
        searchText = ""
        isTextFieldFocused = false
    }
}


#Preview {
    SearchSellerView()
}
