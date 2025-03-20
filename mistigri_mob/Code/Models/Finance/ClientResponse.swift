//
//  ClientResponseData.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct ClientResponse: Decodable {
    let buyers: [ClientResponseData]
}

struct ClientResponseData: Decodable {
    let buyerMail: String
}
