//
//  ContentView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 08/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var coordinator = TabsCoordinator()

    var body: some View {
        coordinator.rootView
    }
}

#Preview {
    ContentView()
}
