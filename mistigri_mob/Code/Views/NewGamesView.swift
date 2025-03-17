//
//  NewGamesView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI

struct NewGamesView: View {
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("New.Text.Title".localized)
                .font(.headline)
                .foregroundColor(Color.C693600)
                .padding(.leading)
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
                            if let minPrice = game.minUnitPrice {
                                Text(String(format: "%.2f", minPrice))
                                            .font(.system(size: 16, weight: .heavy))
                                            .padding(.horizontal, 12)
                                            .padding(.bottom, 3)
                                            .foregroundColor(Color.Ce07800)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.fetchNewGames {
            }
        }
    }
}

#Preview {
    NewGamesView()
}
