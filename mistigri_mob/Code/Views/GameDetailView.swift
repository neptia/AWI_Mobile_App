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
                    if let price = game.minUnitPrice {
                        Text(String(format: "%.2f", price))
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .foregroundColor(Color.Ce07800)
                    }
                    Text("INSTOCK.Text.Title".localized)
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
    }
}
