//
//  ClientSelectionView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//
import SwiftUI

struct ClientSelectionView: View {
    @State private var isAllSelected = false
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
                        financeViewModel.selectedItems.removeAll()
                    } else {
                        financeViewModel.selectedItems = Set(financeViewModel.selectableItems.map { $0.id.uuidString })
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
                    SelectionCell(item: item, selectedItems: $financeViewModel.selectedItems)
                }
            }
        }
    }
}

struct SelectableItem: Identifiable {
    let id = UUID()
    let header: String
    let title: [String]
    let subtitle: String
    let amount: String
}

struct SelectionCell: View {
    let item: SelectableItem
    @Binding var selectedItems: Set<String>

    var isSelected: Bool {
        selectedItems.contains(item.id.uuidString)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(item.header)
                .font(.caption)
                .foregroundColor(.gray)

            HStack {
                VStack(alignment: .leading) {

                    ForEach (item.title, id: \.self) { title in
                        Text(title)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(item.subtitle)
                        .font(.headline)

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
                    selectedItems.remove(item.title.first!)
                } else {
                    selectedItems.insert(item.title.first!)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    ClientSelectionView(financeViewModel: FinanceViewModel())
}
