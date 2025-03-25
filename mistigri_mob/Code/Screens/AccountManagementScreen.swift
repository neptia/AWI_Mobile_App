//
//  AccountManagementScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

struct AccountManagementScreen: View {
    @StateObject var viewModel: AccountManagementViewModel = AccountManagementViewModel()

    var body: some View {
        VStack {
            SearchManagerView(accountManagementViewModel: viewModel)
            UserListView(viewModel: viewModel)
            Spacer()
        }.onAppear {
            FetchAllUser()
        }
    }
}

#Preview {
    AccountManagementScreen()
}
