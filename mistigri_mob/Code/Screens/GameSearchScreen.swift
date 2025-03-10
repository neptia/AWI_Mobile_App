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
                        NavigationLink(destination: GameDetailScreen(game: game)) {
                            Text(game.name)
                        }
                    }
                .searchable(text: $searchText, prompt: "Search for a game...")
                // Search suggestions based on the search text
                .searchSuggestions {
                    Section {
                        // Filtered games suggestions, displaying up to 3 results
                        ForEach(viewModel.filteredGames(searchText: searchText).prefix(3), id: \.id) { suggestion in
                            Text(suggestion.name) // Suggestion display
                                .searchCompletion(suggestion.name) // Completing search text with the suggestion
                        }
                    }
                }
            }
            .onAppear {
                // Fetch games when the view appears
                viewModel.fetchGames {
                    // Handle post-fetch actions if needed
            }
        }
    }
}
