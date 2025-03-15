//
//  GameSearchView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 09/03/2025.
//

import SwiftUI

struct GameSearchScreen: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            // List displaying the filtered games
            List(viewModel.filteredGames(searchText: searchText), id: \.id) { game in
                NavigationLink(destination: GameDetailScreen(game: game, viewModel: viewModel)) {
                    Text(game.name)
                }.listRowBackground(Color.CFFF8F7)
            }.scrollContentBackground(.hidden)
                .background(Color.CFFF3E2)
            .searchable(text: $searchText, prompt: "Search for a game...")
            // Search suggestions based on the search text
            .onAppear {
                // Fetch games when the view appears
                viewModel.fetchAllGames {
                    // Handle post-fetch actions if needed
                }
            }
        }
    }
}

#Preview {
    GameSearchScreen()
}
