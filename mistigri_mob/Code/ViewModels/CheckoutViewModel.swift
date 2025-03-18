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

    func addBarcodetoBasket(input: GameCheckout, alertManager: AlertManager) {
        displayBarcodesAdded.append(input)
    }

    func fetchBarcodesAddedtoBasket() -> [GameCheckout] {
        return displayBarcodesAdded
    }

    func removeBarcodeFromBasket(game: GameCheckout) {
        displayBarcodesAdded.removeAll(where: { $0 == game })
    }
}

