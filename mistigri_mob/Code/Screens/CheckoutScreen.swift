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
        GridItem(.fixed(30), alignment: .topLeading),
        GridItem(.fixed(30), alignment: .topLeading)
    ]
    
    var body: some View {
        VStack {
            HStack {
                TextField("customerEmail.Text.Title".localized, text: $customerEmail)
                    .padding()
                    .background(Color(.systemGray6))
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
                                            .foregroundColor(.red)
                                            .padding(5)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CheckoutScreen().environmentObject(AlertManager())
}
