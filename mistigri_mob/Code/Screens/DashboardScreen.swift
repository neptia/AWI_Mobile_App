//
//  Dashboard.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import SwiftUI
import FloatingButton

struct DashComponent: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let image: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct MockDataDashBoard {
    static let colors = [
        "FFB05C",
        "FFDC73"
    ].map { Color(hex: $0) }

    static let iconImageNames = [
        "widget.small.badge.plus",
        "person.fill.badge.plus"
    ]

    static let iconImageShapes = [
        "heart.fill",
        "heart.fill"
    ]

    static let destinationNames: [AnyView] = [
        AnyView(CreateNewGameScreen().environmentObject(AlertManager())),
        AnyView(CreateNewSellerScreen().environmentObject(AlertManager()))
    ]

}

struct DashboardScreen: View {
    @ObservedObject var alertManager = AlertManager()
    @ObservedObject var dashboardVM: DashboardViewModel = DashboardViewModel()
    @State var isOpen = false

    let mainButton = MainButton(imageName: "plus", colorHex: "ffaedb")
    let buttonsImage = MockDataDashBoard.iconImageNames.enumerated().map { index, value in
        IconButton(imageName: value, color: MockDataDashBoard.colors[index], destination: MockDataDashBoard.destinationNames[index], shape: MockDataDashBoard.iconImageShapes[index])
    }

    let dashComponent: [DashComponent] = [
//        DashComponent(id: UUID(), name: "Home.Text.Title".localized, image: "Dashhome"),
        DashComponent(id: UUID(), name: "Checkout.Text.Title".localized, image: "Checkout"),
        DashComponent(id: UUID(), name: "Deposit.Text.Title".localized, image: "Deposit"),
        DashComponent(id: UUID(), name: "FStatement.Text.Title".localized, image: "FinancialStatement"),
        DashComponent(id: UUID(), name: "Stocks.Text.Title".localized, image: "Stocks"),
        DashComponent(id: UUID(), name: "AccMGT.Text.Title".localized, image: "AccountMGT"),
        DashComponent(id: UUID(), name: "Sessions.Text.Title".localized, image: "Sessions"),
        DashComponent(id: UUID(), name: "Recovery.Text.Title".localized, image: "Recovery"),
        DashComponent(id: UUID(), name: "Fees.Text.Title".localized, image: "Fees"),

    ]

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 40) {
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
                .navigationDestination(for: DashComponent.self) { component in
                    switch component.name {
//                    case "Home.Text.Title".localized:
//                        DashHomeScreen().navigationTitle("Dashboard.Text.Title".localized)
                    case "Deposit.Text.Title".localized:
                        DepositScreen().environmentObject(alertManager).navigationTitle("Deposit.Text.Title".localized)
                    case "Checkout.Text.Title".localized:
                        CheckoutScreen().environmentObject(alertManager)
                            .navigationTitle("Checkout.Text.Title".localized)
                    case "FStatement.Text.Title".localized:
                        FinanceScreen().navigationTitle("FStatement.Text.Title".localized)
                    case "Stocks.Text.Title".localized:
                        StockScreen().navigationTitle("Stocks.Text.Title".localized)
                    case "AccMGT.Text.Title".localized:
                        AccountManagementScreen().navigationTitle("AccMGT.Text.Title".localized)
                    case "Sessions.Text.Title".localized:
                        SessionScreen()
                            .navigationTitle("Sessions.Text.Title".localized)
                    case "Recovery.Text.Title".localized:
                        RecoveryScreen().navigationTitle("Recovery.Text.Title".localized)
                    case "Fees.Text.Title".localized:
                        ConfigureFeeScreen().navigationTitle("Fees.Text.Title".localized)
                    default:
                        Test()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Dashboard.Text.Title".localized)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        VStack {
                            Button(action: {
                                dashboardVM.logout()
                            }) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .padding(3)
                                    .font(.system(size: 15))
                            }.background(Color.CD0BCFF)
                                .foregroundStyle(.white)
                                .cornerRadius(60)
                        }
                    }
                }.toolbarBackground(
                    Color.CFFCAE7,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingButton(mainButtonView: mainButton, buttons: buttonsImage)
                            .straight()
                            .direction(.top)
                            .alignment(.center)
                            .spacing(10)
                            .animation(.spring())
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardScreen()
}
