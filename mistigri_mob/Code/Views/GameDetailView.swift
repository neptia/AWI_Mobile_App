//
//  GameDetailView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 11/03/2025.
//

import SwiftUI

struct GameDetailView: View {
    let game: GameResponseData

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Rectangle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color.CFFE4CE)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.title3)
                    Text("\(game.editor)")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    HStack(alignment: .lastTextBaseline, spacing: 30) {
                        Text("$ 40")
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .foregroundColor(Color.Ce07800)
                        Text("IN STOCK")
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.CD0BCFF)
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                    }
                }
            }
            if let tags = game.tags {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.Cffb05c)
                            .foregroundColor(Color.Ca35400)
                            .cornerRadius(6)
                    }
                }
            }
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.footnote)
                .padding(.top, 10)
                .padding(.trailing, 20)
        }
    }
}
