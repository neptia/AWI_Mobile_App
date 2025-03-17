//
//  PopularGamesView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI

struct PopularGamesView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var selectedTag: String?
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular.Text.Title".localized)
                .font(.headline)
                .foregroundColor(Color.C693600)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: { selectedTag = nil }) { Text("All.Text.Title".localized)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedTag == nil ? Color.Ca35400 : Color.Cffb05c)
                            .foregroundColor(selectedTag == nil ? .white : Color.Ca35400)
                            .cornerRadius(6)
                    }
                    ForEach(viewModel.uniqueTags(), id: \.self) { tag in Button(action: { selectedTag = tag }) {
                        Text(tag)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedTag == tag ? Color.Ca35400 : Color.Cffb05c)
                            .foregroundColor(selectedTag == tag ? .white : Color.Ca35400)
                            .cornerRadius(6)
                    }
                    }
                }
                .padding(.horizontal)
            }.padding(.bottom, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.filteredPopularGames(selectedTag: selectedTag)) { game in
                        VStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.CFFE4CE)
                                .cornerRadius(10)
                            Text(game.name)
                                .font(.body)
                                .padding(.top, 0)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.fetchTopGames { }
        }
    }
}

#Preview {
    PopularGamesView()
}
