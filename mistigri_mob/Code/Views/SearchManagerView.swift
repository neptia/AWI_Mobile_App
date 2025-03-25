//
//  SearchManagerView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

struct SearchManagerView: View {
    @StateObject private var viewModel = AccountManagementViewModel()

    @State private var searchText = ""
    @State private var showSuggestion = true
    @FocusState private var isTextFieldFocused: Bool
    @ObservedObject private var accountManagementViewModel: AccountManagementViewModel

    init(accountManagementViewModel: AccountManagementViewModel) {
        self.accountManagementViewModel = accountManagementViewModel
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
                    viewModel.searchText = searchText
                }
            }
        }
    }
}
