//
//  SearchSellerView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 17/03/2025.
//

import SwiftUI

struct SearchClientView: View {
    @State private var searchText = ""
    @State private var showSuggestion = true
    @ObservedObject var financeViewModel: FinanceViewModel = FinanceViewModel()
    @FocusState private var isTextFieldFocused: Bool

    init(financeViewModel: FinanceViewModel) {
        self.financeViewModel = financeViewModel
    }

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                TextField("SearchClient.Text.Title".localized, text: $searchText, onEditingChanged: { isEditing in
                    showSuggestion = searchText.isEmpty
                })
                .padding()
                .background(Color.CFFDC9A.opacity(0.35))
                .cornerRadius(8)
                .focused($isTextFieldFocused)
                .onSubmit {
                    if let firstClient = financeViewModel.filteredClients(searchText: searchText).first {
                        searchText = firstClient.buyerMail
                        showSuggestion = false
                        financeViewModel.selectedClient = firstClient
                        isTextFieldFocused = false
                        financeViewModel.fetchReceiptsByClient(alertManager: AlertManager())
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

            if showSuggestion, let firstClient = financeViewModel.filteredClients(searchText: searchText).first {
                Button("\(NSLocalizedString("Suggestion.Text.Title", comment: "")): \(firstClient.buyerMail)") {
                    financeViewModel.selectedClient = firstClient
                    searchText = firstClient.buyerMail
                    isTextFieldFocused = false
                    showSuggestion = false
                    financeViewModel.fetchReceiptsByClient(alertManager: AlertManager())
                }
            }
        }
        .padding()
        .onAppear {
            financeViewModel.fetchAllClients {}
        }
    }

    private func clearSearch() {
        searchText = ""
        isTextFieldFocused = false
    }
}


#Preview {
    SearchClientView(financeViewModel: FinanceViewModel())
}
