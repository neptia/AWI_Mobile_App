//
//  FetchClientReceipts.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import Foundation

struct FetchClientReceiptsAction {
    var parameters: ClientReceiptsRequest
    func call(onSuccess: @escaping ([TransactionBuyer]) -> Void, onError: @escaping (String) -> Void) {
        let path: String = "/transaction/buyers/getTransactionBuyerByBuyer"
        let fullUrlString = baseUrl + path
        guard let url = URL(string: fullUrlString) else {
            print("Invalid Url")
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            // Error: Unable to encode request parameters
            print("Unable to encode request parameters")
            onError("Unknown error. Please try again later.")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, testResponse, error in
            guard let httpResponse = testResponse as? HTTPURLResponse else {
                print("Invalid response from server")
                onError("Invalid response from server")
                return
            }
            print("Status Code: \(httpResponse.statusCode)")
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(httpResponse.statusCode)")
                onError("Server error: \(httpResponse.statusCode)")
                return
            }

            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
                let response = try? JSONDecoder().decode(ClientReceiptsResponse.self, from: data)
                if let response = response {
                    print("Receipts fetch successfully")
                    onSuccess(response.TransactionBuyers)
                } else {
                    // Error: Unable to decode response JSON
                    print("Unable to decode response JSON")
                    onError("Unknown error. Please try again.")
                    return
                }
            } else {
                // Error: API request failed
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    onError("Unknown error. Please try again later.")
                }
            }
        }
        task.resume()
    }
}
