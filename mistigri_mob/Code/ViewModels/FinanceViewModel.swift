//
//  FinanceViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//
import SwiftUI

class FinanceViewModel: ObservableObject {
    @Published var clients: [ClientResponseData] = []
    @Published var depositItems: [SelectableItem] = []
    @Published var soldItems: [SelectableItem] = []
    @Published var selectedClient: ClientResponseData = ClientResponseData(buyerMail: "")
    @Published var selectedSeller: SellerResponseData = SellerResponseData(id: "", name: "", email: "", phone: "")
    @Published var clientReceipts: [TransactionBuyer] = [] {
        didSet {
            updateSelectableItemsForClient()
        }
    }
    @Published var sellerReceipts: [TransactionSeller] = [] {
        didSet {
            updateSelectableItemsForSeller()
        }
    }
    @Published var selectableItems: [SelectableItem] = []
    @Published var selectedItems: [SelectableItem] = []

    // Fetch all clients
    func fetchAllClients(completion: @escaping () -> Void) {
        let fetchAction = FetchAllClientsAction()
        fetchAction.call(onSuccess: { clients in
            DispatchQueue.main.async {
                self.clients = clients
                completion()
            }
        }, onError: { error in
            print(error)
        })
    }

    // Filter clients based on search input
    func filteredClients(searchText: String) -> [ClientResponseData] {
        if searchText.isEmpty {
            return []
        } else {
            return clients.filter { $0.buyerMail.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // Fetch receipts for a selected client
    func fetchReceiptsByClient(alertManager: AlertManager) {
        print("Fetching receipts for client: \(selectedClient.buyerMail)")
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

    // Fetch receipts for a selected seller
    func fetchReceiptsBySeller(alertManager: AlertManager) {
        print("Fetching receipts for seller: \(selectedSeller.id)")

        FetchPurchasesBySellerAction().call(
            sellerID: selectedSeller.id,
            onSuccess: { receipts in
                DispatchQueue.main.async {
                    self.sellerReceipts = receipts
                }
            },
            onError: { errorMessage in
                DispatchQueue.main.async {
                    alertManager.showAlertMessage(message: errorMessage)
                }
            }
        )
    }

    // Update selectable items for client receipts
    private func updateSelectableItemsForClient() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .short

        selectableItems = clientReceipts.map { receipt in
            let formattedDate: String
            if let date = dateFormatter.date(from: receipt.date) {
                formattedDate = displayFormatter.string(from: date)
            } else {
                formattedDate = receipt.date
            }
            let gameNames = receipt.purchaseList.map { $0.barcode.game.name }
            return SelectableItem(
                header: formattedDate,
                title: gameNames,
                subtitle: receipt.buyerMail,
                amount: String(format: "%.2f $", receipt.totalPurchaseFee)
            )
        }
    }

    // Update selectable items for seller receipts
    private func updateSelectableItemsForSeller() {
        soldItems = sellerReceipts.map { receipt in
            let gameNames = receipt.barcodeDetails.game.name
            return SelectableItem(
                header: "",  // No date for seller view
                title: [gameNames],  // Wrap in an array to match `title: [String]`
                subtitle: receipt.buyerMail,
                amount: String(format: "%.2f $", receipt.purchaseFee)
            )
        }
    }

    func fetchDeposits(alertManager: AlertManager) {
        SellerFinanceService.call(sellerID: selectedSeller.id, onSuccess: { response in
            // Handle the response, populate depositItems with the data
            DispatchQueue.main.async {
                // You can now directly use response.transactionSellerList as the data you need
                self.depositItems = response.transactionSellerList.flatMap { transactionSeller in
                    transactionSeller.depositList.map { deposit in
                        SelectableItem(
                            header: transactionSeller.date,
                            title: [deposit.game.name],
                            subtitle: deposit.seller_id,
                            amount: String(format: "%.2f $", deposit.depositFee)
                        )
                    }
                }
            }
        }, onError: { errorMessage in
            DispatchQueue.main.async {
                // Show error using alertManager
                alertManager.showAlertMessage(message: errorMessage)
            }
        })
    }

}
