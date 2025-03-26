//
//  VendorGamesView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 11/03/2025.
//

import SwiftUI

struct SameVendorGamesView: View {
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("New.Text.Title".localized)
                .font(.headline)
                .foregroundColor(Color.C693600)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.games, id: \.id) { game in
                        VStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color.CFFE4CE)
                                .cornerRadius(10)
                            Text(game.editor)
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(Color.gray)
                                .padding(.horizontal, 12)
                                .padding(.top, 6)
                            Text(game.name)
                                .font(.body)
                                .padding(.bottom, 0)
                                .padding(.horizontal, 12)
                            Text("$10.99")
                                .font(.system(size: 16, weight: .heavy))
                                .padding(.horizontal, 12)
                                .padding(.bottom, 3)
                                .foregroundColor(Color.Ce07800)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchAllGames { }
        }
    }
}

#Preview {
    SameVendorGamesView()
}
