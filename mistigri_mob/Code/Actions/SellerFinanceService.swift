import Foundation

class SellerFinanceService {

    static func call(sellerID: String, onSuccess: @escaping (TransactionResponse) -> Void, onError: @escaping (String) -> Void) {
        let path: String = "/api/transaction/sellers/getDepositBySeller"
        let fullUrlString = baseUrl + path
        guard let url = URL(string: fullUrlString) else {
            onError("Invalid URL: \(fullUrlString)")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["seller_id": sellerID]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            onError("Failed to encode request body")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    onError("Request failed: \(error.localizedDescription)")
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    onError("No data received")
                }
                return
            }

            do {
                // Decode the response to match the expected structure
                let transactionResponse = try JSONDecoder().decode(TransactionResponse.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(transactionResponse)
                }
            } catch {
                DispatchQueue.main.async {
                    onError("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}

// Models for the response
struct TransactionResponse: Codable {
    let transactionSellerList: [TransactionSeller1]
}

struct TransactionSeller1: Codable {
    let _id: String
    let totalDepositFee: Double
    let date: String
    let depositList: [Deposit]

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case totalDepositFee
        case date
        case depositList
    }
}

struct Deposit: Codable {
    let _id: String
    let seller_id: String
    let quantity: Int
    let depositFee: Double
    let game: Game

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case seller_id
        case quantity
        case depositFee
        case game
    }
}

struct Game: Codable {
    let _id: String
    let name: String
    let editor: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name
        case editor
        case tags
    }
}
