//
//  newSessionRequest.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

struct newSessionRequest: Codable {
    let name: String;
    let startDay: Int;
    let startMonth: Int;
    let startYear: Int;
    let endDay: Int;
    let endMonth: Int;
    let endYear: Int;
}
