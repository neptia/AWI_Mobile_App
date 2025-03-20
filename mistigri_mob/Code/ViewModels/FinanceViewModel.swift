//
//  FinanceViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

class FinanceViewModel: ObservableObject {
    @Published var clients: [ClientResponseData] = []
    @Published var selectedClient: ClientResponseData = ClientResponseData(buyerMail: "")
    @Published var clientReceipts: [ClientReceiptsResponseData] = []

    // Fetch all clients
    func fetchAllClients(completion: @escaping () -> Void) {
        let fetchAction = FetchAllClientsAction()
        fetchAction.call(onSuccess: { clients in
            DispatchQueue.main.async {
                self.clients = clients
                completion()
            }
        }, onError: { error in
            // Handle the error, maybe set a message or alert
            print(error)
        })
    }

    // Function to filter clients based on the search text
    func filteredClients(searchText: String) -> [ClientResponseData] {
        if searchText.isEmpty {
            return []
        } else {
            return clients.filter { $0.buyerMail.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func fetchReceiptsByClient(alertManager: AlertManager) {
        print("===\(selectedClient.buyerMail)")
        FetchClientReceiptsAction(
            parameters: ClientReceiptsRequest(
                email: selectedClient.buyerMail
            )
        ).call(onSuccess: { response in
            self.clientReceipts = response
        }, onError: { errorMessage in
            alertManager.showAlertMessage(message: errorMessage)
        })
    }

    func convertReceiptsToSelectableItems() -> [SelectableItem] {
        return self.clientReceipts.map { purchase in
            SelectableItem(
                header: purchase.barcode_id,
                title: purchase.game.name,
                subtitle: purchase.buyerMail,
                amount: String(format: "%.2f €", purchase.purchaseFee)
            )
        }
    }

}
