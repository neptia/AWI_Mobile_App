//
//  DepositViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import Foundation
import SwiftUI

class DepositViewModel: ObservableObject {
    @Published var selectedSeller: SellerResponseData = SellerResponseData(id: "", name: "", email: "", phone: "")
    @Published var selectedGame: GameResponseData = GameResponseData(id: "", name: "", editor: "", tags: [""], minUnitPrice: 0.0)
    @Published var displayGamesAdded: [GameDeposited] = []
    @Published var gamesAdded: [GameDepositRequestData] = []

    func addGametoBasket(input: GameDeposited, alertManager: AlertManager) {
        if input.isValid {
            displayGamesAdded.append(input)
            self.objectWillChange.send()
        } else {
            alertManager.showAlertMessage(message: "Empty.Text.Title".localized)
        }
    }

    func fetchGamesAddedtoBasket() -> [GameDeposited] {
        return displayGamesAdded
    }

    func clearBasket() {
        displayGamesAdded.removeAll()
        gamesAdded.removeAll()
    }

    func removeGameFromBasket(game: GameDeposited) {
        displayGamesAdded.removeAll(where: { $0 == game })
    }

    func depositGames(alertManager: AlertManager) {
        gamesAdded.removeAll()
        for i in 0..<displayGamesAdded.count {
            for _ in 0..<displayGamesAdded[i].quantity {
                let game = GameDepositRequestData(
                    unitPrice: displayGamesAdded[i].price,
                    comment: displayGamesAdded[i].comment ?? "",
                    state: displayGamesAdded[i].state,
                    game_id: displayGamesAdded[i].game_id,
                    barcode_id: UUID().uuidString
                )
                gamesAdded.append(game)
            }
        }
        guard !gamesAdded.isEmpty else {
            alertManager.showAlertMessage(message: "No games to deposit!")
            return
        }

        DepositAction(parameters: GameDepositRequest(barcodes: gamesAdded, seller_id: selectedSeller.id))
            .call(onSuccess: { response in
                alertManager.showAlertMessage(message: response.message)
            }, onError: { errorMessage in
                alertManager.showAlertMessage(message: "Stock deposit failed")
            })
    }
}
