//
//  DashHomeScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 12/03/2025.
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

struct DashComponentDetail: View {

    let dashComponent: DashComponent

    var body: some View {
        VStack {
            Text(dashComponent.name)
                .font(.system(size: 24))
        }
        .padding()
    }
}
