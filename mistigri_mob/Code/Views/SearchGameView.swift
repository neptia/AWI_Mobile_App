import SwiftUI

struct SearchGameView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var searchText = ""
    @State private var showSuggestion = false
    @ObservedObject var depositViewModel: DepositViewModel = DepositViewModel()

    init(depositViewModel: DepositViewModel = DepositViewModel()) {
        self.depositViewModel = depositViewModel
    }

    var body: some View {
        VStack {
            HStack {
                TextField("SearchGame1.Text.Title".localized, text: $searchText, onEditingChanged: { isEditing in
                    showSuggestion = searchText.isEmpty
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onSubmit {
                    if let firstGame = viewModel.filteredGames(searchText: searchText).first {
                        searchText = firstGame.name
                        showSuggestion = false
                        depositViewModel.selectedGame = firstGame
                    }
                }

                if !searchText.isEmpty {
                    Button(action: clearSearch) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }

            if showSuggestion, let firstGame = viewModel.filteredGames(searchText: searchText).first {
                Button("\(NSLocalizedString("Suggestion.Text.Title", comment: "")): \(firstGame.name)") {
                    searchText = firstGame.name
                    showSuggestion = false
                }
            }
        }
        .padding()
        .onAppear {

            viewModel.fetchAllGames {}
        }
    }

    private func clearSearch() {
        searchText = ""
        showSuggestion = false
    }
}


#Preview {
    SearchGameView()
}
