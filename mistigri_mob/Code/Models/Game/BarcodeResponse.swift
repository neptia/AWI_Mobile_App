//
//  BarcodeRequest.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 18/03/2025.
//

struct BarcodeResponse: Decodable {
    let unsoldBarcodes: [BarcodeResponseData]
}

struct BarcodeResponseData: Decodable {
    let id: String
    let barcode_id: String
    let seller_id: String
    let game_id: String
    let state: String
    let unitPrice: Double
    let comment: String?


    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id
        case seller_id
        case game_id
        case state
        case unitPrice
        case comment
    }
}
