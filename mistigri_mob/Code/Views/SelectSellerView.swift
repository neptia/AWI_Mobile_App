//
//  SelectSellerView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import SwiftUI

struct SelectSellerView: View {
    @StateObject var model = DepositViewModel()
       @State private var selectedSeller: String = "Select a seller"

       var body: some View {
           VStack {
               Menu {
                   ForEach(model.sellers, id: \.id) { seller in
                       Button(seller.name) {
                           selectedSeller = seller.name
                       }
                   }
               } label: {
                   Label(selectedSeller, systemImage: "chevron.down")
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(Color.CFFDC9A.opacity(0.35))
                       .cornerRadius(8)
               }
           }
           .padding()
           .onAppear {
               model.fetchAllSellers{}
           }
       }
}

#Preview {
    SelectSellerView()
}
