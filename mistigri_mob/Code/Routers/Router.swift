//
//  Router.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 09/03/2025.
//

import SwiftUI

class Router: ObservableObject {
    @Published var navigateToDashboardScreen = false
    func navigateToDashboard() {
        DispatchQueue.main.async {
            self.navigateToDashboardScreen = true
        }

    }
}
