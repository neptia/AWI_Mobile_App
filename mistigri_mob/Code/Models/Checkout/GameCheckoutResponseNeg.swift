//
//  GameCheckoutResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 19/03/2025.
//

import SwiftUI

struct GameCheckoutResponseNegative: Decodable {
    var results: [GameCheckoutRepsonseDataNegative]
}

struct GameCheckoutRepsonseDataNegative: Decodable {
    var success: Bool
    var message: String
}
