//
//  GameDetailView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI

struct GameDetailScreen: View {
    let game: GameResponseData
    @State private var selectedPrice: String = "SelectPrice.Text.Title".localized
    @State private var gamePrices: [GamePricesResponseData] = []
    @StateObject var viewModel: GameViewModel
    @State var selectedGame: GamePricesResponseData = GamePricesResponseData(unitPrice: 0.0, name: "", seller_id: "", barcode_id: "", comment: "", state: "")

    var body: some View {
        Color.CFFF8F7
            .ignoresSafeArea()
            .overlay {
                VStack {
                    Image("logo_title")
                        .resizable()
                        .frame(width: 200, height: 40)
                    VStack (alignment: .trailing) {
                        Menu {
                            ForEach(gamePrices, id: \.barcode_id) { game in
                                Button(String(game.unitPrice)) {
                                    selectedPrice = String(game.unitPrice)
                                    selectedGame = game
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
                            Text("\(selectedGame.state) | ")
                            Text(selectedGame.comment ?? "")
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
            }
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
