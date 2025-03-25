//
//  ConfigureFeeScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

import SwiftUI
import Combine

struct ConfigureFeeScreen: View {
    @StateObject var viewModel: ConfigureFeeViewModel = ConfigureFeeViewModel()
    var body: some View {
        ConfigureFeeView(viewModel: viewModel)
        Spacer()
    }
}

#Preview {
    ConfigureFeeScreen()
}
