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
        VStack {
            Text(game.name)
                .font(.largeTitle)
            Text("Editor: \(game.editor)")
                .font(.title2)
            if let tags = game.tags {
                Text("Tags: \(tags.joined(separator: ", "))")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}
