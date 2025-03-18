//
//  CheckoutScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 17/03/2025.
//

import SwiftUI

struct CheckoutScreen: View {
    @StateObject var viewModel: CheckoutViewModel = CheckoutViewModel()
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
            SearchBarcodeView()
            Button(action: {
                
            }) {
                Text("Add Barcode to Basket".localized)
            }.padding()
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
                                    Text(barcode.id.uuidString)
                                    
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
    CheckoutScreen()
}
