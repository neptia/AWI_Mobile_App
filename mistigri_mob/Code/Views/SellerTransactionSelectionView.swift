//
//  SellerTransactionSelectionView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 25/03/2025.
//

import SwiftUI

struct SellerTransactionSelectionView: View {
    @State private var isAllSelected = false
    @ObservedObject var financeViewModel: FinanceViewModel

    var transactionItems: [SelectableItem] {
        financeViewModel.soldItems
    }

    var body: some View {
        VStack {
            HStack {
                Text("Sold Games")
                    .padding()
                Spacer()
                Button(action: {
                    if isAllSelected {
                        financeViewModel.selectedItems.removeAll()
                    } else {
                        financeViewModel.selectedItems = transactionItems
                    }
                    isAllSelected.toggle()
                }) {
                    HStack {
                        Text("Select All")
                        Image(systemName: isAllSelected ? "checkmark.square.fill" : "square")
                    }
                }
                .padding()
            }

            List {
                ForEach(transactionItems, id: \.id) { item in
                    SellerSelectionCell(item: item, selectedItems: $financeViewModel.selectedItems)
                }
            }.background(Color.clear) // Supprime le fond par défaut
                .scrollContentBackground(.hidden)
        }
    }
}
