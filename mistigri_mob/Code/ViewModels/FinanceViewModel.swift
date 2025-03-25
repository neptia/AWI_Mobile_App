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
    @Published var clientReceipts: [TransactionBuyer] = [] {
        didSet {
            updateSelectableItems()
        }
    }
    @Published var selectableItems: [SelectableItem] = []
    @Published var selectedItems: Set<String> = []

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
                buyerMail: selectedClient.buyerMail
            )
        ).call(onSuccess: { response in
            DispatchQueue.main.async {
                self.clientReceipts = response
            }
        }, onError: { errorMessage in
            alertManager.showAlertMessage(message: errorMessage)
        })
    }

    private func updateSelectableItems() {
        selectableItems = clientReceipts.map { receipt in
            let gameNames = receipt.purchaseList.map { $0.barcode.game.name }
            return SelectableItem(
                header: receipt.date,
                title: gameNames,
                subtitle: receipt.buyerMail,
                amount: String(receipt.totalPurchaseFee)
            )
        }
    }


}
