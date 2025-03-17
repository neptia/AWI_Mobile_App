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
            Color.CFFF8F7
                .ignoresSafeArea()
                .overlay {
                    ScrollView(.vertical) {
                        VStack {
                            Image("logo_title")
                                .resizable()
                                .frame(width: 200, height: 40)
                            List {
                                ImageSliderView()
                                    .frame(height: 200)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }.scrollContentBackground(.hidden)
                                .frame(height: 250)
                            VStack {
                                PopularGamesView()
                                NewGamesView()
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    StoreHomeScreen()
}
