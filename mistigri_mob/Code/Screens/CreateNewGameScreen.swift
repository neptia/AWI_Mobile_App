//
//  CreateNewGame.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 19/03/2025.
//

import SwiftUI

struct CreateNewGameScreen: View {
    @State var tags: [String] = []
    @State var viewModel = TagsViewModel()
    @StateObject var gameviewModel = GameViewModel()
    @EnvironmentObject var alertManager: AlertManager

    var body: some View {
        Color.CFFF8F7
            .ignoresSafeArea()
            .overlay {
                VStack {
                    TextField("GameName.Text.Title".localized, text: $gameviewModel.name)
                        .padding()
                        .background(Color.CFFDC9A.opacity(0.35))
                        .cornerRadius(8)
                        .padding(.bottom, 15)
                    TextField("GameEditor.Text.Title".localized, text: $gameviewModel.editors)
                        .padding()
                        .background(Color.CFFDC9A.opacity(0.35))
                        .cornerRadius(8)
                    TagsView(viewModel: viewModel)
                    Button(
                        action: {
                            gameviewModel.tags = viewModel.getAllTagsName()
                            gameviewModel.CreateGame(alertManager: alertManager)
                        },
                        label: {
                            Text("RegisterGame.Text.Title".localized)
                                .font(.system(size: 20, design: .default))
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .foregroundColor(Color.white)
                                .background(Color.Ce0994d)
                                .cornerRadius(10)
                        }
                    )
                    .alert(isPresented: $alertManager.showAlert) {
                        Alert(
                            title: Text("Status"),
                            message: Text(alertManager.alertMessage),
                            dismissButton: .default(Text("OK")))
                    }
                }.padding()
            }.navigationTitle("Register new game")
            .foregroundColor(Color(hex: "693600"))
    }
}

#Preview {
    CreateNewGameScreen().environmentObject(AlertManager())
}
