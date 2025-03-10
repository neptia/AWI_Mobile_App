//
//  StoreHomeScreen.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 09/03/2025.
//

import SwiftUI

struct StoreHomeScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ImageSliderView()
                        .frame(height: 200)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                PopularGamesView()
                NewGamesView()
            }

        }
    }
}

#Preview {
    StoreHomeScreen()
}
