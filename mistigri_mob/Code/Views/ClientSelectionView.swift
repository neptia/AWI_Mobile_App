//
//  ClientSelectionView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//
import SwiftUI

struct ClientSelectionView: View {
    @State private var selectedItems: Set<String> = []
    @State private var isAllSelected = false
    @State private var items: [SelectableItem] = []
    @ObservedObject var financeViewModel: FinanceViewModel = FinanceViewModel()

    init(financeViewModel: FinanceViewModel) {
        self.financeViewModel = financeViewModel
    }

    var body: some View {
        VStack {
            HStack {
                Text("Receipts")
                    .padding()
                Spacer()
                Button(action: {
                    if isAllSelected {
                        selectedItems.removeAll()
                    } else {
                        selectedItems = Set(items.map { $0.title })
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
                ForEach(items, id: \.title) { item in
                    SelectionCell(item: item, selectedItems: $selectedItems)
                }
            }
        }
        .onAppear {
            items = financeViewModel.convertReceiptsToSelectableItems()
        }
    }
}

struct SelectableItem {
    let header: String
    let title: String
    let subtitle: String
    let amount: String
}

struct SelectionCell: View {
    let item: SelectableItem
    @Binding var selectedItems: Set<String>

    var isSelected: Bool {
        selectedItems.contains(item.title)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(item.header)
                .font(.caption)
                .foregroundColor(.gray)

            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(item.amount)
                    .font(.body)
                    .bold()
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(.blue)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if isSelected {
                    selectedItems.remove(item.title)
                } else {
                    selectedItems.insert(item.title)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ClientSelectionView(financeViewModel: FinanceViewModel())
}
