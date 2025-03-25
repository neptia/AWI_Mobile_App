//
//  FinanceScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct FinanceScreen: View {
    @State private var selection: Int = 0

    var body: some View {
        VStack(alignment: .leading) {
            SlidingTabBar(
                selection: $selection,
                tabs: ["Client", "Seller"]
            )
            TabView(selection: $selection) {
                HStack {
                    ClientFinanceView()
                }
                .tag(0)

                HStack {
                    SellerFinanceView()
                }
                .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.default, value: selection)
        }.navigationTitle("Financial Statement")
    }
}

#Preview {
    FinanceScreen()
}
