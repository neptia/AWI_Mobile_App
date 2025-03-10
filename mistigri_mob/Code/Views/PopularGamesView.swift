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
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: { selectedTag = nil }) { Text("All")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedTag == nil ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTag == nil ? .white : .black)
                            .cornerRadius(10)
                    }
                    ForEach(viewModel.uniqueTags(), id: \.self) { tag in Button(action: { selectedTag = tag }) {
                        Text(tag)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedTag == tag ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTag == tag ? .white : .black)
                            .cornerRadius(10)
                    }
                    }
                }
                .padding(.horizontal)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.filteredPopularGames(selectedTag: selectedTag)) { game in
                        VStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray.opacity(0.3))
                                .cornerRadius(10)
                            Text(game.name)
                                .font(.body)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
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
    PopularGamesView()
}
