//
//  GameDetailView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI

struct GameDetailScreen: View {
    let game: GameResponseData
    @State private var selectedPrice: String = "Select a price"
    @State private var gamePrices: [GamePricesResponseData] = []
    @StateObject var viewModel: GameViewModel

    var body: some View {
        VStack (alignment: .trailing) {
                Menu {
                    ForEach(gamePrices, id: \.barcode_id) { game in
                        Button(String(game.unitPrice)) {
                            selectedPrice = String(game.unitPrice)
                        }
                    }
                } label: {
                    Label(selectedPrice, systemImage: "chevron.down")
                        .padding(.all,10)
                        .background(Color.pink.opacity(0.1))
                        .cornerRadius(8)
                }.padding(.trailing,20)
            VStack(alignment:.leading) {
            GameDetailView(game: game)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.footnote)
                .padding(.top, 10)
                .padding(.trailing, 20)
        }
            SameVendorGamesView()
            Spacer()
        }
        .onAppear {fetchPrices()}
        .padding(.leading, 20)
    }

    private func fetchPrices() {
        viewModel.fetchUnitPrices(param: game) { prices in
            DispatchQueue.main.async {
                self.gamePrices = prices
            }
        }
    }
}



#Preview {
    let game = GameResponseData(id: "1", name: "Test Game", editor: "https://via.placeholder.com/150", tags: [""], minUnitPrice: 0.0)
    GameDetailScreen(game: game, viewModel: GameViewModel())
}
