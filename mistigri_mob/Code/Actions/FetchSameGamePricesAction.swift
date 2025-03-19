//
//  FetchSameGamePrices.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 15/03/2025.
//

import Foundation

struct FetchSameGamePricesAction {
    var parameters: GamePricesRequest
    func call(onSuccess: @escaping ([GamePricesResponseData]) -> Void, onError: @escaping (String) -> Void) {
        let path: String = "/games/price"
        let fullUrlString = baseUrl + path
        guard let url = URL(string: fullUrlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            print("Unable to encode request parameters")
            onError("No connection. Please try again later.")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
                let response = try? JSONDecoder().decode(GamePricesResponse.self, from: data)
                if let response = response {
                    onSuccess(response.unitPrices)
                } else {
                    // Error: Unable to decode response JSON
                    print("Unable to decode response JSON")
                    onError("No other prices found.")
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
