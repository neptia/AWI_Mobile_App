//
//  SellerResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

struct SellerResponse: Decodable {
    let sellers: [SellerResponseData]
}

struct SellerResponseData: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let email: String
    let phone: String

    static func == (lhs: SellerResponseData, rhs: SellerResponseData) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case phone
    }
}
