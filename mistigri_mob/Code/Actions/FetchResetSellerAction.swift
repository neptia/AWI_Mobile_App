//
//  FetchResetSellerAction.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 26/03/2025.
//

import Foundation

struct FetchResetSellerAction {
    var parameters: SellerIdRequest
    func call(onSuccess: @escaping (messageResponse) -> Void, onError: @escaping (String) -> Void) {
        let path: String = "/sellers/reset"
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
                let response = try? JSONDecoder().decode(messageResponse.self, from: data)
                if let response = response {
                    onSuccess(response)
                } else {
                    onError("Reset didn't works")
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
