//
//  GameCheckoutRequest.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 18/03/2025.
//

import Foundation

struct GameCheckoutRequest: Encodable {
    var barcodes: [GameCheckoutRequestData]
    var seller_id: String
}

struct GameCheckoutRequestData: Encodable {
    var unitPrice: Double = 0.0
    var comment: String = ""
    var state: String = ""
    var game_id: String = ""
    var barcode_id: String = ""
}
