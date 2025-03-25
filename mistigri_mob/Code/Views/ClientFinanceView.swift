//
//  ClientFinanceView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//
import SwiftUI
import FloatingButton

struct ClientFinanceView: View {
    @StateObject var viewModel: FinanceViewModel = FinanceViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                SearchClientView(financeViewModel: viewModel)
                ClientSelectionView(financeViewModel: viewModel)
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
    ClientFinanceView()
}
