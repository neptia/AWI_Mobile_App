//
//  FetchFeesAction.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 22/03/2025.
//

import Foundation

struct FetchSessionInfoAction {
    func call(onSuccess: @escaping (getSessionInfoResponse) -> Void, onError: @escaping (String) -> Void) {
        let path = "/sessions/getFees"
        let fullUrlString = baseUrl + path
        guard let url = URL(string: fullUrlString) else {
            print("Invalid Url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                onError("No connection. Please try again.")
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(getSessionInfoResponse.self, from: data)
                print("Successfully fetched data")
                onSuccess(decodedData)
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                onError("Unknown error. Please try again later.")
                return
            }
        }
        task.resume()
    }
}
