//
//  GamePricesResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import Foundation

struct GamePricesResponse: Decodable {
    let unitPrices: [GamePricesResponseData]
}

struct GamePricesResponseData: Decodable {
    let unitPrice: Double
    let name: String
    let seller_id: String
    let barcode_id: String
    let comment: String?
    let state: String
}

