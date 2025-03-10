//
//  TabsCoordinator.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import Coordinators
import Foundation
import SwiftUI

class TabsCoordinator: CustomCoordinator {

    enum Tabs: Hashable {
        case tab1
        case tab2
        case tab3
    }

    @Published var currentTab: Tabs = .tab1
    @Published var isLoggedIn: Bool = false
    let alertManager = AlertManager()

    let tab1: CommonCoordinator
    let tab2: CommonCoordinator
    let tab3: CommonCoordinator

    init() {
        tab1 = CommonCoordinator(alertManager: alertManager)
        tab2 = CommonCoordinator(alertManager: alertManager)
        tab3 = CommonCoordinator(alertManager: alertManager)
    }

    func destination() -> some View {
        TabsScreen(coordinator: self)
    }

    struct TabsScreen: View {
        @ObservedObject var coordinator: TabsCoordinator
        var body: some View {
            TabView(selection: $coordinator.currentTab) {
                coordinator.tab1.view(for: .home)
                    .tabItem { Label("", systemImage: "house") }
                    .tag(Tabs.tab1)

                coordinator.tab2.view(for: .search)
                    .tabItem { Label("", systemImage: "sparkle.magnifyingglass") }
                    .tag(Tabs.tab2)

                coordinator.tab3.view(for: .login)
                    .tabItem { Label("", systemImage: "person.crop.circle") }
                    .tag(Tabs.tab3)
            }
        }
    }
}
