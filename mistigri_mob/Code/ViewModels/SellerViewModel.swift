//
//  SellerViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 16/03/2025.
//

import Foundation

class SellerViewModel: ObservableObject {
    @Published var sellers: [SellerResponseData] = []

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""

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

    // Function to perform the seller creation
    func CreateSeller(alertManager: AlertManager) {
        if name.isEmpty || email.isEmpty || phone.isEmpty {
            alertManager.showAlertMessage(message: "Fields cannot be empty")
        } else {
            CreateSellerAction(
                parameters: SellerCreationRequest(
                    name: name, email:email, phone: phone
                )
            ).call(onSuccess: { response in
                alertManager.showAlertMessage(message: response.message)
            }, onError: { errorMessage in
                // Show error alert on login failure
                alertManager.showAlertMessage(message: errorMessage)
            })
        }
    }

}
