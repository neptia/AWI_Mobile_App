//
//  GameResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 09/03/2025.
//

struct GameResponse: Decodable {
    let games: [GameResponseData]
}

struct GameResponseData: Decodable, Identifiable {
    let id: String
    let name: String
    let editor: String
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case editor
        case tags
    }
}
