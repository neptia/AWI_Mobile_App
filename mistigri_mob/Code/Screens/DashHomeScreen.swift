//
//  DashHomeScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 12/03/2025.
//
import SwiftUI

struct DashHomeScreen: View {
    @ObservedObject var router: Router
    
    var body: some View {
        VStack {
            Text("Dash Home")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    router.resetToDashboard()
                }) {
                    Label("Back", systemImage: "arrow.left.circle")
                }
            }
        }
    }
}
