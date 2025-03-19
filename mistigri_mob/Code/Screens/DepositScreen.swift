//
//  DepositScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import SwiftUI

struct DepositScreen: View {
    @StateObject var viewModel: DepositViewModel = DepositViewModel()
    @EnvironmentObject var alertManager: AlertManager
    @State var isMultiple: Bool = false
    @State private var price = 0.0
    @State private var state: stateOptions = .new
    @State private var comment = ""
    @State var quantity = 1

    enum stateOptions: String {
        case new
        case used
        case refurbished
    }

    let columns = [
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.fixed(30), alignment: .topLeading)
    ]

    var body: some View {
        Color.CFFF8F7
            .ignoresSafeArea()
            .overlay {
                VStack {
                    SearchSellerView(depositViewModel: viewModel)
                    VStack {
                        Form {
                            Section(header: Text("Game.Text.Title".localized)) {
                                SearchGameView(depositViewModel: viewModel)
                                Toggle("Multiple.Text.Title".localized, isOn: $isMultiple)
                                    .tint(Color(hex:"d0bcff"))
                                TextField("Price.Text.Title".localized, value: $price, formatter: NumberFormatter.price)
                                Picker("Price.Text.Title".localized, selection: $state) {
                                    Text("New.Text.Title".localized).tag(stateOptions.new)
                                    Text("Used.Text.Title".localized).tag(stateOptions.used)
                                    Text("Refurbished.Text.Title".localized).tag(stateOptions.refurbished)
                                }

                                if state == .used {
                                    TextField("Missing.Text.Title".localized, text: $comment)
                                }

                                if (isMultiple && state != .used) {
                                    Stepper("\(NSLocalizedString("Quantity.Text.Title", comment: "")): \(quantity)", value: $quantity, in: 2...50)

                                }
                                Button("AddGame.Text.Title".localized) {
                                    viewModel.addGametoBasket(input: GameDeposited(game_id:viewModel.selectedGame.id, title: viewModel.selectedGame.name,state: state.rawValue,comment: comment, quantity: isMultiple ? quantity : 1, price: price), alertManager: alertManager
                                    )
                                }
                                .alert(isPresented: $alertManager.showAlert) {
                                    Alert(
                                        title: Text("Status.Text.Title".localized),
                                        message: Text(alertManager.alertMessage),
                                        dismissButton: .default(Text("OK")))
                                }
                                .frame(maxWidth: .infinity, alignment: .init(horizontal: .center, vertical: .center))
                                .listRowBackground(Color(hex: "fcceff").opacity(0.45))
                            }
                            .listRowBackground(Color(hex: "ffe3e3").opacity(0.25))


                            Section {
                                LazyVGrid(columns: columns, spacing: 10) {
                                    // Header Row
                                    Text("Basket.Text.Title".localized)
                                        .fontWeight(.bold)
                                    Text("Qty.Text.Title".localized)
                                        .fontWeight(.light)
                                    Text("Price.Text.Title".localized)
                                        .fontWeight(.bold)
                                    Text("")
                                        .fontWeight(.bold)

                                    // Data Rows
                                    ForEach(viewModel.fetchGamesAddedtoBasket(), id: \.id) { game in
                                        VStack(alignment:.leading) {
                                            Text(game.title)
                                            Text(game.state)
                                                .foregroundColor(.secondary)
                                            if game.comment != nil {
                                                Text(game.comment!)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        Text(String(game.quantity)+" *")
                                        Text(game.priceString)
                                        HStack {
                                            Button(action: {
                                                viewModel.removeGameFromBasket(game: game)
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(Color(hex:"8a226f"))
                                                    .padding(5)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                            .listRowBackground(Color(hex: "ffecec"))
                        }.scrollContentBackground(.hidden)
                            .foregroundColor(Color(hex:"693600"))
                            .background(Color(hex:"fff8f7"))

                        Button(
                            action: {
                                viewModel.depositGames(alertManager: alertManager)
                            },
                            label: {
                                Text("Deposit.Text.Title".localized)
                            }
                        ).frame(width: UIScreen.main.bounds.width - 60, height: 40)
                            .alert(isPresented: $alertManager.showAlert) {
                                Alert(
                                    title: Text("Status.Text.Title".localized),
                                    message: Text(alertManager.alertMessage),
                                    dismissButton: .default(Text("OK")))
                            }
                            .background(Color(hex:"ffaedb"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
            }
    }
}


#Preview {
    DepositScreen().environmentObject(AlertManager())
}
