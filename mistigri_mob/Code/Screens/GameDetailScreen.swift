//
//  GameDetailView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI

struct GameDetailScreen: View {
    let game: GameResponseData

    var body: some View {
        VStack() {
            GameDetailView(game: game)
            SameVendorGamesView()
            Spacer()
        }
        .padding(.leading, 20)
    }
}

#Preview {
    let game = GameResponseData(
        id: "123",
        name: "Test Game",
        editor: "Test Editor",
        tags: ["tag1", "tag2"]
    )
    GameDetailScreen(game: game)
}
