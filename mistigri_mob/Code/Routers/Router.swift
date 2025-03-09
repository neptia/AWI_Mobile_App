//
//  Router.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 09/03/2025.
//

import SwiftUI

class Router: ObservableObject {
    @Published var navigateToStoreHomeScreen = false

    func navigateToStoreHome() {
        self.navigateToStoreHomeScreen = true
    }
}
