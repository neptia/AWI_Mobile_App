//
//  SelectSellerView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import SwiftUI

struct SelectSellerView: View {
    @StateObject var viewModel: SellerViewModel = SellerViewModel()
    @ObservedObject var depositViewModel = DepositViewModel()
    @State private var selectedSeller: String = "SelectSeller.Text.Title".localized

    init(depositViewModel: DepositViewModel = DepositViewModel()) {
        self.depositViewModel = depositViewModel
    }

    var body: some View {
        VStack {
            Menu {
                ForEach(viewModel.sellers, id: \.id) { seller in
                    Button(seller.name) {
                        selectedSeller = seller.name
                        depositViewModel.selectedSeller = seller
                    }
                }
            } label: {
                Label(selectedSeller, systemImage: "chevron.down")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.CFFDC9A.opacity(0.35))
                    .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchAllSellers {}
        }
    }
}

#Preview {
    SelectSellerView()
}
