//
//  getAll.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

struct GetAllUserResponse: Decodable {
    let users: [User]
}

struct User: Decodable, Encodable {
    let id: String
    let name: String
    let role: String
    let email: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case role
        case email
        case password
    }
}
