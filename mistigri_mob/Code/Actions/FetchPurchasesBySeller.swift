//
//  FetchPurchesesBySeller.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 25/03/2025.
//
import Foundation

struct FetchPurchasesBySellerAction {
    func call(sellerID: String, onSuccess: @escaping ([TransactionSeller]) -> Void, onError: @escaping (String) -> Void) {
        let path = "/purchases/bySeller"
        let fullUrlString = baseUrl + path
        guard let url = URL(string: fullUrlString) else {
            print("Invalid URL")
            onError("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = SellerReceiptsRequest(seller_id: sellerID)

        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            print("Failed to encode request body:", error)
            onError("Failed to encode request. Please try again.")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                onError("No connection. Please try again later.")
                return
            }
            guard let data = data else {
                print("No data received")
                onError("No data received. Please try again later.")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(SellerReceiptsResponse.self, from: data)
                print("Successfully fetched seller receipts")
                onSuccess(decodedData.purchases)
            } catch let jsonError {
                print("Failed to decode JSON:", jsonError)
                onError("Failed to fetch seller receipts. Please try again later.")
            }
        }
        task.resume()
    }
}
