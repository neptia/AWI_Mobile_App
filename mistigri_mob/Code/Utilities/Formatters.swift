//
//  Formatters.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 16/03/2025.
//

import SwiftUI

extension NumberFormatter {
    static let price: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
