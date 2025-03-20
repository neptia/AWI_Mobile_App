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
    @Published var gameViewModel: GameViewModel = GameViewModel()
    @Published var gamesAdded: [String] = []
    @Published var customerEmail: String = ""

    func addBarcodetoBasket(barcode: String, email: String, alertManager: AlertManager) {
        if (email.isEmpty || barcode.isEmpty) {
            alertManager.showAlertMessage(message: "Empty.Text.Title".localized)
        } else  {
            gameViewModel.getGameTitleFromID(id: selectedBarcode.game_id) { gameTitle in
                let game: GameCheckout = GameCheckout(title: gameTitle, state: self.selectedBarcode.state, comment: self.selectedBarcode.comment, price: self.selectedBarcode.unitPrice, game_id: self.selectedBarcode.game_id, barcode_id: self.selectedBarcode.barcode_id)
                self.displayBarcodesAdded.append(game)
            }
            self.customerEmail=email
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
            gamesAdded.append(displayBarcodesAdded[i].barcode_id)
        }
        guard !gamesAdded.isEmpty else {
            alertManager.showAlertMessage(message: "No games to purchase!")
            return
        }

        CheckoutAction(parameters: GameCheckoutRequest(barcodeList: gamesAdded, buyerMail: self.customerEmail))
            .call(onSuccess: { response in
                alertManager.showAlertMessage(message: response.message)
            },onPartialSuccess: { errorResponse in
                var log: String = ""
                for result in errorResponse.results {
                    log += "Success: \(result.success), Message: \(result.message)"
                }
                alertManager.showAlertMessage(message: log)
            },
                  onError: { errorMessage in
                alertManager.showAlertMessage(message: "Stock checkout failed")
            })
    }
}

