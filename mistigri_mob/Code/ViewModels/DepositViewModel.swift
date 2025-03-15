//
//  DepositViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import Foundation

class DepositViewModel: ObservableObject {
    @Published var sellers: [SellerResponseData] = []

    // Fetch all sellers
    func fetchAllSellers(completion: @escaping () -> Void) {
        let fetchAction = FetchAllSellersAction()
        fetchAction.call(onSuccess: { sellers in
            DispatchQueue.main.async {
                self.sellers = sellers
                completion()
            }
        }, onError: { error in
            // Handle the error, maybe set a message or alert
            print(error)
        })
    }
}
