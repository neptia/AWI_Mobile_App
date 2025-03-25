struct GameStockBySellerResponse: Decodable {
    let sold: [SoldGameResponse]
    let unsold: [UnsoldGameResponse]
}

struct UnsoldGameResponse: Decodable {
    let id: String
    let barcode_id: String
    let seller_id: String
    let game_id: String
    let state: String
    let unitPrice: Double
    let comment: String?
    let gameDetails: SoldGameDetailsResponse

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id
        case seller_id
        case game_id
        case state
        case unitPrice
        case comment
        case gameDetails
    }
}

struct SoldGameResponse: Decodable {
    let id: String
    let barcode_id: String
    let seller_id: String
    let game_id: String
    let state: String
    let unitPrice: Double
    let comment: String?
    let purchaseInfo: [SoldGamePurchaseInfoResponse]
    let gameDetails: SoldGameDetailsResponse

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id
        case seller_id
        case game_id
        case state
        case unitPrice
        case comment
        case purchaseInfo
        case gameDetails
    }
}

struct SoldGamePurchaseInfoResponse: Decodable {
    let id: String
    let barcode_id: String
    let purchaseFee: Double
    let buyerMail: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case barcode_id
        case purchaseFee
        case buyerMail
    }
}

struct SoldGameDetailsResponse: Decodable {
    let name: String
    let editor: String
    let tags: [String]
}
