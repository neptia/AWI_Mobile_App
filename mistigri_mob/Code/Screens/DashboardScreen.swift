//
//  Dashboard.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI
struct DashboardScreen: View {
    @ObservedObject var router: Router

    var body: some View {
        VStack {
            Text("Dashboard")

            Button("Go to Home") {
                router.path.append("dashhome")
            }
        }
        .navigationDestination(for: String.self) { value in
            if value == "dashhome" {
                DashHomeScreen(router: router)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}
