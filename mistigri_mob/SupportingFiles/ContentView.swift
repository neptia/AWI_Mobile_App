//
//  ContentView.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 08/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var alertManager = AlertManager()

    var body: some View {
        LoginScreen(router: Router())
            .environmentObject(alertManager)
    }
}

#Preview {
    ContentView()
}
