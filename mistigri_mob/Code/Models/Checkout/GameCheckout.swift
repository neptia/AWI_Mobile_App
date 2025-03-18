//
//  GameCheckout.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 18/03/2025.
//

import SwiftUI

struct GameCheckout: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var state: String
    var comment: String?
    var price: Double

    static func == (lhs: GameCheckout, rhs: GameCheckout) -> Bool {
        return lhs.id == rhs.id
    }

    var priceString: String {
        String(format: "%.2f", price)
    }

}
