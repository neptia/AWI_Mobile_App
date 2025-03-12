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
        case tab4
    }

    @Published var currentTab: Tabs = .tab1
    let alertManager = AlertManager()

    let tab1: CommonCoordinator
    let tab2: CommonCoordinator
    let tab3: CommonCoordinator
    let tab4: CommonCoordinator

    init() {
        tab1 = CommonCoordinator(alertManager: alertManager)
        tab2 = CommonCoordinator(alertManager: alertManager)
        tab3 = CommonCoordinator(alertManager: alertManager)
        tab4 = CommonCoordinator(alertManager: alertManager)
        UITabBar.appearance().backgroundColor = UIColor(Color.CFFF3E2)
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

                coordinator.tab3.view(for: .all)
                    .tabItem { Label("", systemImage: "square.grid.3x3.square") }
                    .tag(Tabs.tab3)

                coordinator.tab4.view(for: .login)
                    .tabItem { Label("", systemImage: "lock.shield") }
                    .tag(Tabs.tab4)
            }
        }
    }
}
