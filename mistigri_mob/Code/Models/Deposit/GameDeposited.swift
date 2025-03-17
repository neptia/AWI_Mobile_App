//
//  GameDeposited.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 16/03/2025.
//

import SwiftUI

struct GameDeposited: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var state: String
    var comment: String?
    var quantity: Int = 1
    var price: Double

    static func == (lhs: GameDeposited, rhs: GameDeposited) -> Bool {
        return lhs.id == rhs.id
    }

    var priceString: String {
        String(format: "%.2f", price)
    }

    var isValid: Bool {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !state.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              price > 0 else {
            return false
        }
        return true
    }
}
