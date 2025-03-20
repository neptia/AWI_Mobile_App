//
//  GameCreationResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 19/03/2025.
//

import SwiftUI

struct GameCreationResponse: Decodable {
    let message: String
    let game: GameCreationResponseData
}

struct GameCreationResponseData: Decodable {
    let name: String
    let editor: String
    let tags: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case editor
        case tags
    }
}
