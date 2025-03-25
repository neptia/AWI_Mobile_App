//
//  getResumeResponse.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 24/03/2025.
//

struct getResumeResponse: Decodable {
    let totalPurchaseFee: Double;
    let totalUnitPrice: Double;
    let purchaseNumber: Int;
    let totalStockQuantity: Int;
    let totalDepositFee: Double;
}
