//
//  GameStockBySeller.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

struct GameStockBySellerView: View {
    @ObservedObject var viewModel: StockViewModel
    @State private var selectedTab: Tab = .sold

    enum Tab {
        case sold, unsold
    }

    var body: some View {
        Picker("Selection", selection: $selectedTab) {
            Text("Sold").tag(Tab.sold)
            Text("Unsold").tag(Tab.unsold)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()

        if selectedTab == .sold {
            SoldGamesListView(viewModel: viewModel)
        } else {
            UnsoldGamesListView(viewModel: viewModel)
        }
    }
}

#Preview {
    GameStockBySellerView(viewModel: StockViewModel())
}
