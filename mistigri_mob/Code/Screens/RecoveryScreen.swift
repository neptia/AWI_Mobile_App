//
//  RecoveryScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 24/03/2025.
//

import SwiftUI

struct RecoveryScreen: View {
    @StateObject var viewModel: RecoveryViewModel = RecoveryViewModel()
    @ObservedObject var alertManager = AlertManager()

    var body : some View {
        SearchSellerView(recoveryViewModel: viewModel)
        SellerResumeView(viewModel: viewModel).environmentObject(alertManager)
        Spacer()
    }
}

#Preview {
    RecoveryScreen()
}
