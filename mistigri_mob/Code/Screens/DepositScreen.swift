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
    @State private var depositFee: Double = 0.0

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
                                Picker("State.Text.Title".localized, selection: $state) {
                                    Text("New.Text.Title".localized).tag(stateOptions.new)
                                    Text("Used.Text.Title".localized).tag(stateOptions.used)
                                    Text("Refurbished.Text.Title".localized).tag(stateOptions.refurbished)
                                }
                                .onChange(of: state) { newState in
                                    if newState != .used {
                                        comment = "" // Reset du commentaire
                                    }
                                    if newState != .new {
                                        quantity = 1 // Remise à zéro de la quantité
                                    }
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
                                    resetFields()
                                    calculateDepositFees()
                                }
                                .alert(isPresented: $alertManager.showAlert) {
                                    Alert(
                                        title: Text("Status.Text.Title".localized),
                                        message: Text(alertManager.alertMessage),
                                        dismissButton: .default(Text("OK"), action: {
                                            resetFields() // Réinitialisation après alerte réussie
                                        })
                                    )
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
                                                calculateDepositFees()
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(Color(hex:"8a226f"))
                                                    .padding(5)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                                HStack {
                                    Text("Total Fees:")
                                    Spacer()
                                    Text("\(depositFee, specifier: "%.2f") $")
                                        .fontWeight(.bold)
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
                                    dismissButton: .default(Text("OK"), action: {
                                        clear() // Réinitialisation complète après dépôt
                                    })
                                )
                            }
                            .background(Color(hex:"ffaedb"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
            }
    }

    private func resetFields() {
        price = 0.0
        state = .new
        comment = ""
        quantity = 1
    }

    private func clear() {
        price = 0.0
        state = .new
        comment = ""
        quantity = 1
        depositFee = 0.0
        viewModel.clearBasket()
    }

    // Fonction pour calculer les frais de dépôt
    private func calculateDepositFees() {
        let totalPrice = viewModel.fetchGamesAddedtoBasket().reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        print("Total Price sent to API:", totalPrice)

        guard let url = URL(string: "http://mistigribackend.cluster-ig4.igpolytech.fr/api/fees/deposit/calculate") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["price": totalPrice]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching fees:", error.localizedDescription)
                return
            }

            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("API Response:", jsonResponse ?? "Invalid JSON")

                    if let fee = jsonResponse?["fee"] as? Double {
                        DispatchQueue.main.async {
                            self.depositFee = fee
                            print("Updated deposit fee:", self.depositFee)
                        }
                    }
                } catch {
                    print("JSON Parsing Error:", error.localizedDescription)
                }
            }
        }.resume()
    }

}


#Preview {
    DepositScreen().environmentObject(AlertManager())
}
