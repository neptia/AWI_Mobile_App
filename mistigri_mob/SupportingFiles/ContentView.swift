//
//  ContentView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 08/03/2025.
//

import SwiftUI

struct ContentView: View {

    var body: some View {

        RootScreen()
            .environmentObject(Auth.shared)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
