//
//  SellerFinanceView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 25/03/2025.
//

import SwiftUI

struct SellerFinanceView: View {
    @StateObject var viewModel: FinanceViewModel = FinanceViewModel()
    @State private var selectedTab: Tab = .sold

    enum Tab {
        case sold, deposit
    }

    var body: some View {
        ZStack {
            VStack {
                SearchSellerView(financeViewModel: viewModel)
                SellerTransactionSelectionView(financeViewModel: viewModel)
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    GenerateReceiptsView(financeViewModel: viewModel)
                        .padding(.trailing, 20)
                }
            }
        }
    }
}

#Preview {
    SellerFinanceView()
}

