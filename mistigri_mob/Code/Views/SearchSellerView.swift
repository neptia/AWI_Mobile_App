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
    @State private var showSuggestion = false
    @ObservedObject var depositViewModel: DepositViewModel = DepositViewModel()

    init(depositViewModel: DepositViewModel = DepositViewModel()) {
        self.depositViewModel = depositViewModel
    }

    var body: some View {
        VStack {
            HStack {
                TextField("SearchSeller.Text.Title".localized, text: $searchText, onEditingChanged: { isEditing in
                    showSuggestion = searchText.isEmpty
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onSubmit {
                    if let firstSeller = viewModel.filteredSellers(searchText: searchText).first {
                        searchText = firstSeller.name
                        showSuggestion = false
                        depositViewModel.selectedSeller = firstSeller
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

            if showSuggestion, let firstSeller = viewModel.filteredSellers(searchText: searchText).first {
                Button("\(NSLocalizedString("Suggestion.Text", comment: "")): \(firstSeller.name)") {
                    searchText = firstSeller.name
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
        showSuggestion = false
    }
}


#Preview {
    SearchSellerView()
}
