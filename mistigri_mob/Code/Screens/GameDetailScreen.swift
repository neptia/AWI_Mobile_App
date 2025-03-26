    //
    //  GameDetailView.swift
    //  mistigri_mob
    //
    //  Created by Poomedy Rungen on 10/03/2025.
    //
import SwiftUI

struct GameDetailScreen: View {
    let gameInfo: GameResponseData
    @State private var selectedPrice: String = "SelectPrice.Text.Title".localized
    @State private var gamePrices: [GamePricesResponseData] = []
    @State private var selectedGame: GamePricesResponseData?
    @StateObject var viewModel: GameViewModel

    var body: some View {
        Color.CFFF8F7
            .ignoresSafeArea()
            .overlay {
                VStack {
                    Image("logo_title")
                        .resizable()
                        .frame(width: 200, height: 40)

                    VStack(alignment: .trailing) {
                        Menu {
                            ForEach(gamePrices, id: \.barcode_id) { game in
                                Button("$ \(String(game.unitPrice))") {
                                    selectedPrice = String(game.unitPrice)
                                    selectedGame = game
                                }
                            }
                        } label: {
                            Label("Options.Text.Title".localized, systemImage: "chevron.down")
                                .padding(.all, 10)
                                .background(Color.pink.opacity(0.1))
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 20)

                        VStack(alignment: .leading) {
                            GameDetailView(game: gameInfo)
                                .padding(.trailing, 40)
                            if let selectedGame = selectedGame {
                                HStack {
                                    Text("\(selectedGame.state)")
                                        .foregroundColor(.gray)
                                    if let comment = selectedGame.comment {
                                        Text(" | \(comment)")
                                            .foregroundColor(.gray)
                                    }
                                }
                            } else {
                                Text("NoInfo.Text.Title".localized)
                                    .foregroundColor(.gray)
                            }
                        }
                        NewGamesView()
                        Spacer()
                    }
                    .onAppear {
                        fetchPrices()
                    }
                }
            }
    }

    private func fetchPrices() {
        viewModel.fetchUnitPrices(param: gameInfo) { prices in
            DispatchQueue.main.async {
                self.gamePrices = prices
                if let cheapestGame = viewModel.getMinimumGame() {
                    self.selectedGame = cheapestGame
                    self.selectedPrice = String(cheapestGame.unitPrice)
                }
            }
        }
    }
}

#Preview {
    let game = GameResponseData(id: "1", name: "Test Game", editor: "https://via.placeholder.com/150", tags: [""], minUnitPrice: 0.0)
    GameDetailScreen(gameInfo: game, viewModel: GameViewModel())
}

