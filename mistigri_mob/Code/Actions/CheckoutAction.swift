//
//  CheckoutAction.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 19/03/2025.
//

import Foundation

struct CheckoutAction {
    var parameters: GameCheckoutRequest
    func call(onSuccess: @escaping (GameCheckoutResponsePositive) -> Void, onPartialSuccess: @escaping (GameCheckoutResponseNegative) -> Void, onError: @escaping (String) -> Void) {
        let path: String = "/purchases"
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
            let jsonData = try JSONEncoder().encode(parameters)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("------------ JSON Sent to Server:\n\(jsonString)")
            }
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

            guard let data = data else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    onError("Network error. Please try again.")
                }
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                // Try decoding as GameCheckoutResponsePositive
                if let response = try? JSONDecoder().decode(GameCheckoutResponsePositive.self, from: data) {
                    print("Successfully purchased games")
                    onSuccess(response)
                }
                // If decoding fails, try as GameCheckoutResponseNegative
                else if let errorResponse = try? JSONDecoder().decode(GameCheckoutResponseNegative.self, from: data) {
                    print("Partial success or failure in purchases")
                    onPartialSuccess(errorResponse)
                } else {
                    print("Unknown response format")
                    onError("Unexpected server response")
                }
            } else {
                print("Successfully purchased games")
                onError("Successfully purchased games")
            }
        }
        task.resume()
    }
}

