import SwiftUI

struct SoldGamesListView: View {
    @ObservedObject var viewModel: StockViewModel

    var body: some View {
        VStack {
            Picker("Group by", selection: $viewModel.groupedBy) {
                Text("All").tag("all")
                Text("By game").tag("game")
                Text("By editor").tag("editor")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if viewModel.groupedBy == "all" {
                List(viewModel.sold, id: \.id) { soldGame in
                    gameRow(soldGame)
                }
            } else if viewModel.groupedBy == "game" {
                let groupedByGame = Dictionary(grouping: viewModel.sold, by: { $0.gameDetails.name })
                List(groupedByGame.keys.sorted(), id: \.self) { gameName in
                    if let games = groupedByGame[gameName] {
                        VStack(alignment: .leading) {
                            Text(gameName)
                                .font(.headline)
                            Text("Quantity : \(games.count)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            } else if viewModel.groupedBy == "editor" {
                let groupedByEditor = Dictionary(grouping: viewModel.sold, by: { $0.gameDetails.editor })
                List(groupedByEditor.keys.sorted(), id: \.self) { editorName in
                    if let games = groupedByEditor[editorName] {
                        VStack(alignment: .leading) {
                            Text(editorName)
                                .font(.headline)
                            Text("Quantity : \(games.count)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }

    private func gameRow(_ soldGame: SoldGameResponse) -> some View {
        VStack(alignment: .leading) {
            Text(soldGame.gameDetails.name)
                .font(.headline)
            Text("Commission fees : \(soldGame.purchaseInfo[0].purchaseFee, specifier: "%.2f") $").font(.subheadline)
            Text("Buyer mail: \(soldGame.purchaseInfo[0].buyerMail)").font(.subheadline)
            Text("Editor : \(soldGame.gameDetails.editor)").font(.subheadline)
            Text("Price : \(soldGame.unitPrice, specifier: "%.2f") €")
                .foregroundColor(.green)
            if let comment = soldGame.comment {
                Text("Comment : \(comment)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(5)
    }
}
