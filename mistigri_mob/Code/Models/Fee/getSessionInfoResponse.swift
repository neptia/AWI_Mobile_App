//
//  getFeesResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

struct getSessionInfoResponse: Encodable, Decodable {
    // {"totalDepositFee":390.30000000000007,"totalCommissionFee":23.1,"totalPurchase":46.2,"gameSold":1,"stockAvailable":null}

    let totalDepositFee: Double
    let totalCommissionFee: Double
    let totalPurchase: Double
    let gameSold: Int
    let stockAvailable: Int?
}
