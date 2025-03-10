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
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.games, id: \.id) { game in
                        VStack {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.gray.opacity(0.3))
                                .cornerRadius(10)
                            Text(game.name)
                                .font(.body)
                                .padding(.horizontal, 12)
                                .padding(.top, 6)
                            Text(game.editor)
                                .font(.body)
                                .padding(.horizontal, 12)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.fetchGames { }
        }
    }
}

#Preview {
    NewGamesView()
}
