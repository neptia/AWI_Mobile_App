//
//  Dashboard.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI
struct DashboardScreen: View {
    private var dashComponent: [DashComponent]

    init(dashComponent: [DashComponent]) {
        self.dashComponent = dashComponent
    }

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(dashComponent) { component in
                    NavigationLink(value: component) {
                        VStack {
                            Text(component.name)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .navigationDestination(for: DashComponent.self) { dashComponent in
            DashComponentDetail(dashComponent: dashComponent)
        }
    }
}

#Preview {
    var dashComponent: [DashComponent] = [
        DashComponent(id: UUID(), name: "Room 1", image: "room1"),
        DashComponent(id: UUID(), name: "Room 2", image: "room2"),
        DashComponent(id: UUID(), name: "Room 3", image: "room3")
    ]
    DashboardScreen(dashComponent: dashComponent)
}
