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
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case message
        case game
    }
}

struct GameCreationResponseData: Decodable {
    let name: String
    let tags: [String]
}
