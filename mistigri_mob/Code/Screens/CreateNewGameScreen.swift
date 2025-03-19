//
//  CreateNewGame.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 19/03/2025.
//

import SwiftUI

struct CreateNewGameScreen: View {
    @State var gameName: String = ""


    var body: some View {
        TextField("hello", text: $gameName)
    }
}

#Preview {
    CreateNewGameScreen()
}
