//
//  AllGamesScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 12/03/2025.
//

import SwiftUI

struct AllGamesScreen: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var selectedTag: String?
    private let flexibleColumn = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]

    var body: some View {
        Color.CFFF8F7
            .ignoresSafeArea()
            .overlay {
                VStack(alignment: .leading) {
                    Text("AllGames.Text.Title".localized)
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
                    ScrollView {
                        LazyVGrid(columns: flexibleColumn, spacing: 20) {
                            ForEach(viewModel.filteredPopularGames(selectedTag: selectedTag)) { game in
                                VStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color.CFFE4CE)
                                        .cornerRadius(10)
                                    Text(game.editor)
                                        .font(.system(size: 15, weight: .light))
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 12)
                                        .padding(.top, 6)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                    Text(game.name)
                                        .font(.body)
                                        .padding(.bottom, 0)
                                        .padding(.horizontal, 12)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                    Text("$ "+String(game.minUnitPrice ?? 0.0))
                                        .font(.system(size: 16, weight: .heavy))
                                        .padding(.horizontal, 12)
                                        .padding(.bottom, 3)
                                        .foregroundColor(Color.Ce07800)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .onAppear {
                    viewModel.fetchNewGames{ }
                }
            }
    }
}

#Preview {
    AllGamesScreen()
}
