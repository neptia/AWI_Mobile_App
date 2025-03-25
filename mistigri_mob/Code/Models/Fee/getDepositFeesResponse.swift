struct getDepositFeesResponse: Codable {
    let depositFees: [DepositFee]  // Utilisation du camelCase pour être plus Swift-friendly

    enum CodingKeys: String, CodingKey {
        case depositFees = "DepositFees"
    }
}

struct DepositFee: Codable {
    let id: String
    let state: String
    let amount: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case state
        case amount
    }
}
