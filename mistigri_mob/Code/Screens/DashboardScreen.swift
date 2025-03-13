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
                            Image(component.image)
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .bottom)
                            Text(component.name)
                                .font(.headline)
                                .foregroundColor(Color.C693600)
                        }
                        .padding()
                        .frame(maxWidth: 150, minHeight: 150)
                        .background(Color.CFFE4CE)
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .navigationDestination(for: DashComponent.self) { _ in
            DashComponentDetail()
        }
    }
}

#Preview {
    let dashComponent: [DashComponent] = [
        DashComponent(id: UUID(), name: "Home", image: "Dashhome"),
        DashComponent(id: UUID(), name: "Checkout", image: "Checkout"),
        DashComponent(id: UUID(), name: "Deposit", image: "Deposit")
    ]
    DashboardScreen(dashComponent: dashComponent)
}
