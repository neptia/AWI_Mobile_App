//
//  SellerReceiptsResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 25/03/2025.
//
import SwiftUI

struct SellerReceiptsResponse: Codable {
    let purchases: [TransactionSeller]
}

struct TransactionSeller: Codable, Identifiable {
    let id: String
    let barcode_id: String
    let purchaseFee: Double
    let buyerMail: String
    let barcodeDetails: BarcodeDetails

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id, purchaseFee, buyerMail, barcodeDetails
    }
}

struct BarcodeDetails: Codable {
    let id: String
    let barcode_id: String
    let seller_id: String
    let game_id: String
    let state: String
    let unitPrice: Double
    let comment: String
    let game: GameDetails

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id, seller_id, game_id, state, unitPrice, comment, game
    }
}

struct GameDetails: Codable {
    let id: String
    let name: String
    let editor: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, editor, tags
    }
}
