//
//  SearchGamesVM.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var games: [GameResponseData] = [] // Store the games
    @Published var gamePrices: [GamePricesResponseData] = []
    @Published var isLoading = false
    @Published var game_id: String = ""

    // Fetch all games
    func fetchAllGames(completion: @escaping () -> Void) {
        let fetchAction = FetchAllGamesAction()
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

    // Fetch top games
    func fetchTopGames(completion: @escaping () -> Void) {
        let fetchAction = FetchTopGamesAction()
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

    // Filtered games based on selected tag
    func filteredPopularGames(selectedTag: String?) -> [GameResponseData] {
        if let tag = selectedTag {
            return games.filter { $0.tags?.contains(tag) ?? false }
        }
        return games
    }

    // Get unique game tags
    func uniqueTags() -> [String] {
        let allTags = games.compactMap { $0.tags }.flatMap { $0 }
        return Array(Set(allTags)).sorted()
    }

    func fetchUnitPrices(param: GameResponseData, completion: @escaping ([GamePricesResponseData]) -> Void) {
        let fetchAction = FetchSameGamePricesAction(parameters: GamePricesRequest(game_id: param.id))
        fetchAction.call(onSuccess: { games in
            DispatchQueue.main.async {
                self.gamePrices = games
                completion(games)
            }
        }, onError: { error in
            print(error)
        })
    }

}
