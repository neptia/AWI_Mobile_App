//
//  GameCheckoutResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 19/03/2025.
//

import SwiftUI

struct GameCheckoutResponse: Decodable {
    var results: [GameCheckoutRepsonseData]
}

struct GameCheckoutRepsonseData: Decodable {
    var success: Bool
    var message: String
}
