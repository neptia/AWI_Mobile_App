//
//  DashboardViewModel.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 14/03/2025.
//

import Foundation

class DashboardViewModel: ObservableObject {

    func logout() {
        Auth.shared.logout()
    }
}
