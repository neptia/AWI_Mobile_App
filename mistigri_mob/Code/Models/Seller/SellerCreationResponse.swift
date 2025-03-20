//
//  SellerCreationResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct SellerCreationResponse: Decodable {
    let message: String
    let seller: SellerCreationResponseData
}

struct SellerCreationResponseData: Decodable {
    var name: String
    var email: String
    var phone: String
    var id: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case phone
    }
}
