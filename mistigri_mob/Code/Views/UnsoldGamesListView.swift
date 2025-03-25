import SwiftUI

struct UnsoldGamesListView: View {
    @ObservedObject var viewModel: StockViewModel

    var body: some View {
        VStack {
            Picker("Group by", selection: $viewModel.groupedBy) {
                Text("All").tag("all")
                Text("By Game").tag("game")
                Text("By Editor").tag("editor")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if viewModel.groupedBy == "all" {
                List(viewModel.unsold, id: \.id) { unsoldGame in
                    gameRow(unsoldGame)
                }
            } else if viewModel.groupedBy == "game" {
                let groupedByGame = Dictionary(grouping: viewModel.unsold, by: { $0.gameDetails.name })
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
                let groupedByEditor = Dictionary(grouping: viewModel.unsold, by: { $0.gameDetails.editor })
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

    private func gameRow(_ unsoldGame: UnsoldGameResponse) -> some View {
        VStack(alignment: .leading) {
            Text(unsoldGame.gameDetails.name)
                .font(.headline)
            Text("Editor : \(unsoldGame.gameDetails.editor)").font(.subheadline)
            Text("Price : \(unsoldGame.unitPrice, specifier: "%.2f") €")
                .foregroundColor(.green)
            let barcode = unsoldGame.barcode_id
            Text("Barcode : \(barcode)")
                .font(.footnote)
                .foregroundColor(.gray)

            if let comment = unsoldGame.comment {
                Text("Comment : \(comment)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(5)
    }
}
