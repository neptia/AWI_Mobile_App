//
//  SelectGaemView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import SwiftUI

struct SelectGameView: View {
    @StateObject var viewModel = GameViewModel()
    @ObservedObject var depositViewModel: DepositViewModel = DepositViewModel()
    @State private var selectedGame: String = "SelectGame.Text.Title".localized

    init(depositViewModel: DepositViewModel = DepositViewModel()) {
        self.depositViewModel = depositViewModel
    }

    var body: some View {
        VStack {
            Menu {
                ForEach(viewModel.games, id: \.id) { game in
                    Button(game.name) {
                        selectedGame = game.name
                        depositViewModel.selectedGame = game
                    }
                }
            } label: {
                Label(selectedGame, systemImage: "chevron.down")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.CFFDC9A.opacity(0.35))
                    .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchAllGames  {}
        }
    }
}

