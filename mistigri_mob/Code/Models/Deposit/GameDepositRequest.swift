//
//  GameDepositRequest.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 17/03/2025.
//

import Foundation

struct GameDepositRequest: Encodable {
    var barcodes: [GameDepositRequestData]
    var seller_id: String
}

struct GameDepositRequestData: Encodable {
    var unitPrice: Double = 0.0
    var comment: String = ""
    var state: String = ""
    var game_id: String = ""
    var barcode_id: String = ""
}
