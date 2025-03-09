//
//  showError.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 09/03/2025.
//

import SwiftUI

class AlertManager: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""

    // Function to trigger the alert with a custom message
    func showAlertMessage(message: String) {
        alertMessage = message
        showAlert = true
        print("Alert shown with message: \(message)")
    }
}
