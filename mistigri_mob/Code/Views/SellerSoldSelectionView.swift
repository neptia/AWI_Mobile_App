//
//  SellerSelectionView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 25/03/2025.
//

import SwiftUI

struct SellerSoldSelectionView: View {
    @State private var isAllSelected = false
    @ObservedObject var financeViewModel: FinanceViewModel

    init(financeViewModel: FinanceViewModel) {
        self.financeViewModel = financeViewModel
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
                        financeViewModel.selectedItems = financeViewModel.selectableItems
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
                ForEach(financeViewModel.selectableItems, id: \.id) { item in
                    SellerSelectionCell(item: item, selectedItems: $financeViewModel.selectedItems)
                }
            }
        }
    }
}

struct SellerSelectionCell: View {
    let item: SelectableItem
    @Binding var selectedItems: [SelectableItem]

    var isSelected: Bool {
        selectedItems.contains(where: { $0.id == item.id })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Buyer: \(item.subtitle)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    ForEach(item.title, id: \.self) { game in
                        Text(game)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                Text("\(item.amount)")
                    .font(.body)
                    .bold()
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(.blue)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if isSelected {
                    selectedItems.removeAll { $0.id == item.id }
                } else {
                    selectedItems.append(item)
                }
                print("Selected Seller Items: \(selectedItems.map { $0.id })")
            }
        }
        .padding(.vertical, 5)
    }
}

