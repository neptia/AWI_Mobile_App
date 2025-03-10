//
//  SearchGamesVM.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import Foundation

class SearchGamesViewModel: ObservableObject {
    @Published var games: [GameResponseData] = [] // Store the games
    @Published var isLoading = false

    // Fetch the games from the network or local storage
    func fetchGames(completion: @escaping () -> Void) {
        let fetchAction = FetchGamesAction()
        fetchAction.call(onSuccess: { games in
            DispatchQueue.main.async {
                self.games = games
                completion()
            }
        }, onError: { error in
            // Handle the error, maybe set a message or alert
            print(error)
        })
    }

    // Function to filter games based on the search text
    func filteredGames(searchText: String) -> [GameResponseData] {
        if searchText.isEmpty {
            return []
        } else {
            return games.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
