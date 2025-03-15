//
//  RootScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 14/03/2025.
//

import SwiftUI

struct RootScreen: View {

    @EnvironmentObject var auth: Auth
    @StateObject var coordinator = TabsCoordinator()

    var body: some View {
        if auth.loggedIn {
            DashboardScreen()
        } else {
            coordinator.rootView
        }
    }
}

