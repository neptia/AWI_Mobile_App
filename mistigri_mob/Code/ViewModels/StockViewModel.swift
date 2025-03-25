//
//  StockViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI
import Combine

class StockViewModel: ObservableObject {
    @Published var selectedSeller: SellerResponseData = SellerResponseData(id: "", name: "", email: "", phone: "") {
        didSet {
            fetchGameStockBySeller{}
        }
    }
    public var loading: Bool = false

    @Published var sold: [SoldGameResponse] = []
    @Published var unsold: [UnsoldGameResponse] = []
    @Published var groupedBy: String = "all"

    func fetchGameStockBySeller(completion: @escaping () -> Void) {
        let fetchAction = FetchGameStockBySeller(parameters:GameStockBySellerRequest(seller_id: selectedSeller.id))
        fetchAction.call(onSuccess: { response in
            DispatchQueue.main.async {
                print("----------------------")
                self.sold = response.sold
                self.unsold = response.unsold
                completion()
            }
        }, onError: { error in
            print("dddddddddddddddddddddd")
            print(error)
        })
    }

}
