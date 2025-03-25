//
//  FetchNewSession.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

import Foundation

struct FetchNewSession {
    var parameters: newSessionRequest
    func call(onSuccess: @escaping (newSessionResponse) -> Void, onError: @escaping (String) -> Void) {
        let path: String = "/sessions"
        let fullUrlString = baseUrl + path
        guard let url = URL(string: fullUrlString) else {
            print("Invalid Url")
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
                let response = try? JSONDecoder().decode(newSessionResponse.self, from: data)
                if let response = response {
                    print("Receipts fetch successfully")
                    if(200...299).contains(httpResponse.statusCode){
                        onError("\(response)")
                    } else {
                        onSuccess(response)
                    }
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
