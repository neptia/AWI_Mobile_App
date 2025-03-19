//
//  CheckoutViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 18/03/2025.
//

import Foundation

class CheckoutViewModel: ObservableObject {
    @Published var selectedBarcode: BarcodeResponseData = BarcodeResponseData(id: "", barcode_id: "", seller_id: "", game_id: "", state: "", unitPrice: 0.0, comment: "")
    @Published var displayBarcodesAdded: [GameCheckout] = []
    @Published var barcodeAdded: [GameCheckoutRequestData] = []
    @Published var gameViewModel: GameViewModel = GameViewModel()
    @Published var gamesAdded: [GameCheckoutRequestData] = []

    func addBarcodetoBasket(barcode: String, email: String, alertManager: AlertManager) {
        if (email.isEmpty || barcode.isEmpty) {
            alertManager.showAlertMessage(message: "Empty.Text.Title".localized)
        } else  {
            print(selectedBarcode.game_id)
            gameViewModel.getGameTitleFromID(id: selectedBarcode.game_id) { gameTitle in
                let game: GameCheckout = GameCheckout(title: gameTitle, state: self.selectedBarcode.state, comment: self.selectedBarcode.comment, price: self.selectedBarcode.unitPrice)
                self.displayBarcodesAdded.append(game)
            }
        }
    }

    func fetchBarcodesAddedtoBasket() -> [GameCheckout] {
        return displayBarcodesAdded
    }

    func removeBarcodeFromBasket(game: GameCheckout) {
        displayBarcodesAdded.removeAll(where: { $0 == game })
    }

    func checkoutGames(alertManager: AlertManager) {
        gamesAdded.removeAll()
        for i in 0..<displayBarcodesAdded.count {
            let game = GameCheckoutRequestData(
                unitPrice: displayBarcodesAdded[i].price,
                comment: displayBarcodesAdded[i].comment ?? "",
                state: displayBarcodesAdded[i].state,
                game_id: displayBarcodesAdded[i].,
                barcode_id: displayBarcodesAdded[i].
            )
            gamesAdded.append(game)
        }
        guard !gamesAdded.isEmpty else {
            alertManager.showAlertMessage(message: "No games to purchase!")
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

