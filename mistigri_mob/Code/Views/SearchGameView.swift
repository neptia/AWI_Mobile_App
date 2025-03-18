import SwiftUI

struct SearchGameView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var searchText = ""
    @State private var showSuggestion = true
    @ObservedObject var depositViewModel: DepositViewModel = DepositViewModel()
    @FocusState private var isTextFieldFocused: Bool

    init(depositViewModel: DepositViewModel = DepositViewModel()) {
        self.depositViewModel = depositViewModel
    }

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                TextField("SearchGame1.Text.Title".localized, text: $searchText, onEditingChanged: { isEditing in
                    showSuggestion = searchText.isEmpty
                })
                .padding()
                .background(Color.CFFDC9A.opacity(0.35))
                .cornerRadius(8)
                .focused($isTextFieldFocused)
                .onSubmit {
                    if let firstGame = viewModel.filteredGames(searchText: searchText).first {
                        searchText = firstGame.name
                        showSuggestion = false
                        depositViewModel.selectedGame = firstGame
                        isTextFieldFocused = false
                    }
                }

                if !searchText.isEmpty {
                    Button(action: clearSearch) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(hex: "fdd3d0"))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 8)
                }
            }

            if showSuggestion, let firstGame = viewModel.filteredGames(searchText: searchText).first {
                Button("\(NSLocalizedString("Suggestion.Text.Title", comment: "")): \(firstGame.name)") {
                    depositViewModel.selectedGame = firstGame
                    searchText = firstGame.name
                    showSuggestion = false
                    isTextFieldFocused = false
                }.buttonStyle(PlainButtonStyle())
                    .foregroundStyle(Color(hex: "693600"))
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchAllGames {}
        }
    }

    private func clearSearch() {
        searchText = ""
        isTextFieldFocused = false
    }
}


#Preview {
    SearchGameView()
}
