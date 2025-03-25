//
//  Session.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

struct Session: Decodable {
    let id: String
    let name: String?
    let startDate: String
    let endDate: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case startDate
        case endDate
    }
}
