//
//  getCommissionFees.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

struct getCommissionFeesResponse: Encodable, Decodable {
    // {"CommissionFees":[{"_id":"672d0f29cf5475aec37a4320","state":"percentage","amount":0.5}]}
    let CommissionFees: [CommissionFee];
}

struct CommissionFee: Encodable, Decodable {
    let id: String;
    let state: String;
    let amount: Double;

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case state
        case amount
    }
}
