//
//  GameCheckoutRequest.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 18/03/2025.
//

import Foundation

struct GameCheckoutRequest: Encodable {
    var barcodeList: [String]
    var buyerMail: String
}

