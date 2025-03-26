//
//  RecoveryViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 24/03/2025.
//

import SwiftUI

class RecoveryViewModel: ObservableObject {
    @Published var totalPurchaseFee: Double = 0
    @Published var totalUnitPrice: Double = 0
    @Published var purchaseNumber: Int = 0
    @Published var totalStockQuantity: Int = 0
    @Published var totalDepositFee: Double = 0

    @Published var selectedSeller: SellerResponseData = SellerResponseData(id: "", name: "", email: "", phone: "") {
        didSet {
            fetchSellerResume(){}
            print(selectedSeller)
        }
    }

    func fetchSellerResume(completion: @escaping () -> Void) {
        let fetchAction = FetchSellerResume(parameters:sellerIdRequest(seller_id: selectedSeller.id))
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                self.totalPurchaseFee = response.totalPurchaseFee
                self.totalUnitPrice = response.totalUnitPrice
                self.purchaseNumber = response.purchaseNumber
                self.totalStockQuantity = response.totalStockQuantity
                self.totalDepositFee = response.totalDepositFee
                completion()
            }
        }, onError: { error in
            print(error)
        })
    }

    func fetchResetSeller(alertManager: AlertManager) {
        let fetchAction = FetchResetSellerAction(parameters: SellerIdRequest(seller_id: selectedSeller.id))
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                alertManager.showAlertMessage(message: response.message)

            }
        }, onError: { error in
            alertManager.showAlertMessage(message: error)
            print(error)
        })
    }
}
