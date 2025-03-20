//
//  ClientReceiptsResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct ClientReceiptsResponse: Decodable {
    var purchases: [ClientReceiptsResponseData]
}

struct ClientReceiptsResponseData: Decodable {
    var id: String
    var barcode_id: String
    var purchaseFee: Double
    var buyerMail: String
    var game: GameData

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id
        case purchaseFee
        case buyerMail
        case game
    }
}

struct GameData: Decodable {
    var id: String
    var name: String
    var editor: String
    var tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case editor
        case tags
    }
}
