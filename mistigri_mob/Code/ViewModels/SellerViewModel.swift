//
//  SellerViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 16/03/2025.
//

import Foundation

class SellerViewModel: ObservableObject {
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

    // Function to filter sellers based on the search text
    func filteredSellers(searchText: String) -> [SellerResponseData] {
        if searchText.isEmpty {
            return []
        } else {
            return sellers.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
