//
//  SessionScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

struct SessionScreen: View {
    @StateObject var viewModel: SessionViewModel = SessionViewModel()

    var body: some View {
        VStack {
            CurrentSessionView(viewModel: viewModel)
            SessionListView(viewModel: viewModel)
            Spacer()
        }
    }
}

#Preview {
    SessionScreen()
}
