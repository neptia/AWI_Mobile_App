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
    @Published var totalCommission: Double = 0.0
    @Published var totalPrice: Double = 0.0
    @Published var totalNet: Double = 0.0

    func addBarcodetoBasket(barcode: String, email: String, alertManager: AlertManager) {
        if (email.isEmpty || barcode.isEmpty) {
            alertManager.showAlertMessage(message: "Empty.Text.Title".localized)
        } else  {
            gameViewModel.getGameTitleFromID(id: selectedBarcode.game_id) { gameTitle in
                let game: GameCheckout = GameCheckout(title: gameTitle, state: self.selectedBarcode.state, comment: self.selectedBarcode.comment, price: self.selectedBarcode.unitPrice, game_id: self.selectedBarcode.game_id, barcode_id: self.selectedBarcode.barcode_id)
                self.displayBarcodesAdded.append(game)
                self.calculateCommission()
            }
            self.customerEmail=email
        }
    }

    func fetchBarcodesAddedtoBasket() -> [GameCheckout] {
        return displayBarcodesAdded
    }

    func removeBarcodeFromBasket(game: GameCheckout) {
        displayBarcodesAdded.removeAll(where: { $0 == game })
        calculateCommission()
    }

    func clearBasket() {
        displayBarcodesAdded.removeAll()
        objectWillChange.send()
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
                self.clearBasket()  // Vide le panier
                self.customerEmail = ""  // Réinitialise l'email
                self.totalCommission = 0.0  // Reset le total
                self.totalPrice = 0.0
                self.totalNet = 0.0
            },onPartialSuccess: { errorResponse in
                var log: String = ""
                for result in errorResponse.results {
                    log += "Success: \(result.success), Message: \(result.message)"
                }
                alertManager.showAlertMessage(message: log)
            },
                  onError: { errorMessage in
                alertManager.showAlertMessage(message: "Successfully purchased games")
                self.clearBasket()  // Vide le panier
                self.customerEmail = ""  // Réinitialise l'email
                self.totalCommission = 0.0  // Reset le total
                self.totalPrice = 0.0
                self.totalNet = 0.0
            })
        
    }

    func calculateCommission() {
        let basket = fetchBarcodesAddedtoBasket()
        print("Current basket contents:", basket)

        let totalPrice = basket.reduce(0) { $0 + $1.price }
        print("Total Price before API call:", totalPrice)

        guard totalPrice > 0 else {
            print("Error: Basket is empty or price is 0")
            return
        }

        guard let url = URL(string: "http://mistigribackend.cluster-ig4.igpolytech.fr/api/fees/commission/calculate") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["price": totalPrice]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching commission:", error.localizedDescription)
                return
            }

            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("API Response:", jsonResponse ?? "Invalid JSON")

                    if let fee = jsonResponse?["fee"] as? Double {
                        DispatchQueue.main.async {
                            self.totalCommission = fee
                            let basket = self.fetchBarcodesAddedtoBasket()
                            print("Current basket contents:", basket)
                            self.totalPrice = basket.reduce(0) { $0 + $1.price }
                            self.totalNet = self.totalPrice + self.totalCommission
                            print("Updated commission fee:", self.totalCommission)
                        }
                    }
                } catch {
                    print("JSON Parsing Error:", error.localizedDescription)
                }
            }
        }.resume()
    }

}

