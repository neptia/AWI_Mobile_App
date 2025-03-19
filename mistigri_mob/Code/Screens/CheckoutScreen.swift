//
//  CheckoutScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 17/03/2025.
//

import SwiftUI

struct CheckoutScreen: View {
    @StateObject var viewModel: CheckoutViewModel = CheckoutViewModel()
    @EnvironmentObject var alertManager: AlertManager
    @State var customerEmail: String = ""

    let columns = [
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.fixed(50), alignment: .topLeading),
        GridItem(.fixed(30), alignment: .topLeading)
    ]

    var body: some View {
        Color.CFFF8F7
            .ignoresSafeArea()
            .overlay {
                VStack {
                    HStack {
                        TextField("customerEmail.Text.Title".localized, text: $customerEmail)
                            .padding()
                            .background(Color.CFFDC9A.opacity(0.35))
                            .cornerRadius(8)
                            .autocapitalization(.none)
                    }.padding()
                    SearchBarcodeView(checkoutVM: viewModel)

                    Button(action: {
                        viewModel.addBarcodetoBasket(barcode: viewModel.selectedBarcode.barcode_id, email:customerEmail, alertManager: alertManager)
                    }) {
                        Text("AddGame.Text.Title".localized)
                    }.padding()
                        .alert(isPresented: $alertManager.showAlert) {
                            Alert(
                                title: Text("Status.Text.Title".localized),
                                message: Text(alertManager.alertMessage),
                                dismissButton: .default(Text("OK")))
                        }
                        .background(Color(hex: "fcceff").opacity(0.45))
                        .cornerRadius(50)

                    VStack {
                        Form {
                            Section {
                                LazyVGrid(columns: columns, spacing: 10) {
                                    // Header Row
                                    Text("Basket.Text.Title".localized)
                                        .fontWeight(.bold)
                                    Text("Price.Text.Title".localized)
                                        .fontWeight(.bold)
                                    Text("")
                                        .fontWeight(.bold)

                                    // Data Rows
                                    ForEach(viewModel.fetchBarcodesAddedtoBasket(), id: \.id) { barcode in
                                        VStack(alignment:.leading) {
                                            Text(barcode.title)
                                            Text(barcode.state)
                                                .foregroundColor(.secondary)
                                            if barcode.comment != nil {
                                                Text(barcode.comment!)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        Text(barcode.priceString)
                                        HStack {
                                            Button(action: {
                                                viewModel.removeBarcodeFromBasket(game: barcode)
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(Color(hex:"8a226f"))
                                                    .padding(5)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }.listRowBackground(Color(hex: "ffecec"))
                        }.scrollContentBackground(.hidden)
                            .foregroundColor(Color(hex:"693600"))
                            .background(Color(hex:"fff8f7"))


                        Button(
                            action: {
                                viewModel.checkoutGames(alertManager: alertManager)
                            },
                            label: {
                                Text("Checkout.Text.Title".localized)
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
                }}
    }
}

#Preview {
    CheckoutScreen().environmentObject(AlertManager())
}
