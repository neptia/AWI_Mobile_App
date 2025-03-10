//
//  CommonCoordinator.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI
import Coordinators

class CommonCoordinator: NavigationCoordinator {
    @ObservedObject var alertManager = AlertManager()

    init(alertManager: AlertManager) {
            self.alertManager = alertManager
        }

    // screens available for navigation
    enum Screen: ScreenProtocol {
        case home
        case login
        case search
    }

    // view for each screen
    func destination(for screen: Screen) -> some View {
        switch screen {
        case .home: StoreHomeScreen()
        case .login: LoginScreen(router: Router()).environmentObject(alertManager)
        case .search: GameSearchScreen()
        }
    }
}
