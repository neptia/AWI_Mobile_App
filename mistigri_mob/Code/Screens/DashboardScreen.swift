//
//  Dashboard.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI

struct DashComponent: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let image: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct DashboardScreen: View {
    @ObservedObject var alertManager = AlertManager()
    @ObservedObject var dashboardVM: DashboardViewModel = DashboardViewModel()

    let dashComponent: [DashComponent] = [
        DashComponent(id: UUID(), name: "Home.Text.Title".localized, image: "Dashhome"),
        DashComponent(id: UUID(), name: "Checkout.Text.Title".localized, image: "Checkout"),
        DashComponent(id: UUID(), name: "Deposit.Text.Title".localized, image: "Deposit")
    ]

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
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
            .navigationTitle("Dashboard.Text.Title".localized)
            .navigationDestination(for: DashComponent.self) { component in
                switch component.name {
                case "Home":
                    DashHomeScreen()
                case "Deposit":
                    DepositScreen().environmentObject(alertManager)
                case "Checkout":
                    CheckoutScreen()
                default:
                    DashHomeScreen()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        dashboardVM.logout()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardScreen()
}
