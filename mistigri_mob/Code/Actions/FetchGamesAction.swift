//
//  FetchGamesAction.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 10/03/2025.
//

import Foundation

struct FetchGamesAction {
    func call(onSuccess: @escaping ([GameResponseData]) -> Void, onError: @escaping (String) -> Void) {
        let path = "/games/100"
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
                onError("No connection. Please try again later.")
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(GameResponse.self, from: data)
                // Assigning the data to the array
                print("Successfully fetched data")
                onSuccess(decodedData.games)
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                onError("No connection. Please try again later.")
                return
            }
        }
        task.resume()
    }
}
