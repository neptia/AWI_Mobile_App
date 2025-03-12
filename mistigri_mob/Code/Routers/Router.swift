//  Router.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 09/03/2025.
//

import SwiftUI


class Router: ObservableObject {
    @Published var path = NavigationPath()

    func navigateToDashboard() {
        DispatchQueue.main.async {
            self.path.append("dashboard") // ✅ Push Dashboard onto the navigation stack
        }
    }

    func resetToDashboard() {
        DispatchQueue.main.async {
            self.path = NavigationPath() // ✅ Reset stack to make Dashboard the root
            self.path.append("dashboard")
        }
    }
}
