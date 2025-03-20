//
//  CreateNewSeller.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct CreateNewSellerScreen: View {
    @StateObject var sellerViewModel = SellerViewModel()
    @EnvironmentObject var alertManager: AlertManager

    var body: some View {
        Color.CFFF8F7
            .ignoresSafeArea()
            .overlay {
                VStack {
                    TextField("SellerName.Text.Title".localized, text: $sellerViewModel.name)
                        .padding()
                        .background(Color.CFFDC9A.opacity(0.35))
                        .cornerRadius(8)
                        .padding(.bottom, 15)
                    TextField("SellerEmail.Text.Title".localized, text: $sellerViewModel.email)
                        .padding()
                        .background(Color.CFFDC9A.opacity(0.35))
                        .cornerRadius(8)
                        .padding(.bottom, 15)
                    TextField("SellerPhone.Text.Title".localized, text: $sellerViewModel.phone)
                        .padding()
                        .background(Color.CFFDC9A.opacity(0.35))
                        .cornerRadius(8)
                        .padding(.bottom, 15)
                    Spacer()
                    Button(
                        action: {
                            sellerViewModel.CreateSeller(alertManager: alertManager)
                        },
                        label: {
                            Text("RegisterSeller.Text.Title".localized)
                                .font(.system(size: 20, design: .default))
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .foregroundColor(Color.white)
                                .background(Color.Ce0994d)
                                .cornerRadius(10)
                        }
                    )
                    .alert(isPresented: $alertManager.showAlert) {
                        Alert(
                            title: Text("Status"),
                            message: Text(alertManager.alertMessage),
                            dismissButton: .default(Text("OK")))
                    }
                }.padding()
            }.navigationTitle("Register new seller")
    }
}

#Preview {
    CreateNewSellerScreen().environmentObject(AlertManager())
}
