//
//  LoginViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 08/03/2025.
//

import Foundation
import SwiftUI
import Coordinators

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @ObservedObject var router: Router

    init(router: Router) {
        self.router = router
    }

    // Function to perform the login
    func login(alertManager: AlertManager) {
        LoginAction(
            parameters: LoginRequest(
                email: email,
                password: password
            )
        ).call(onSuccess: { [self] _ in
            // Login succesful go to homepage
            DispatchQueue.main.async {
                self.router.path.append("dashboard")
            }
        }, onError: { errorMessage in
            // Show error alert on login failure
            alertManager.showAlertMessage(message: errorMessage)
        })
    }
}
