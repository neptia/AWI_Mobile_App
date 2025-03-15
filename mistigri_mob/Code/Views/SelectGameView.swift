//
//  SelectGaemView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import SwiftUI

struct SelectGameView: View {
    @StateObject var model = GameViewModel()
    @State private var selectedGame: String = "Select a game"
    

    var body: some View {
        VStack {
            Menu {
                ForEach(model.games, id: \.id) { game in
                    Button(game.name) {
                        selectedGame = game.name
                    }
                }
            } label: {
                Label(selectedGame, systemImage: "chevron.down")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.CFFDC9A.opacity(0.35))
                    .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            model.fetchAllGames {
            }
        }
    }
}

#Preview {
    SelectGameView()
}
