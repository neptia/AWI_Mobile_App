//
//  St.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

struct StockScreen: View {
    @StateObject var viewModel: StockViewModel = StockViewModel()

    var body: some View {
        VStack {
            SearchSellerView(stockViewModel: viewModel) // Placé en haut
            CustomSeparator()
            if(viewModel.loading) {
                LoadingView()
            }
            GameStockBySellerView(viewModel: viewModel)
            Spacer() // Pousse l'élément vers le haut
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct CustomSeparator: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex:Color.mauve)) // Couleur personnalisée (changez ici)
                .frame(height: 60) // Hauteur de 100px
                .edgesIgnoringSafeArea(.horizontal) // Prendre toute la largeur de l'écran

            Text("List of product")
                .font(.title) // Vous pouvez personnaliser la taille de la police ici
                .foregroundColor(.white) // Couleur du texte
                .bold() // Optionnel : met en gras le texte
        }
    }
}

#Preview {
    StockScreen()
}

