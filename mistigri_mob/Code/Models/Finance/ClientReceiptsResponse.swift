//
//  ClientReceiptsResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct ClientReceiptsResponse: Decodable {
    var TransactionBuyers: [TransactionBuyer]
}

struct TransactionBuyer: Decodable {
    var id: String
    var totalPurchaseFee: Double
    var totalPurchaseAmount: Double
    var date: String
    var purchaseList: [PurchaseData]
    var buyerMail: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case totalPurchaseFee
        case totalPurchaseAmount
        case date
        case purchaseList
        case buyerMail
    }
}

struct PurchaseData: Decodable {
    var id: String
    var barcode_id: String
    var purchaseFee: Double
    var buyerMail: String
    var barcode: BarcodeData

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id
        case purchaseFee
        case buyerMail
        case barcode
    }
}

struct BarcodeData: Decodable {
    var id: String
    var seller_id: String
    var game_id: String
    var state: String
    var unitPrice: Double
    var comment: String
    var game: GameData

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case seller_id
        case game_id
        case state
        case unitPrice
        case comment
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
