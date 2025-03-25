//
//  FetchAllUser.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 21/03/2025.
//

import SwiftUI

struct FetchAllUser {
    func call(onSuccess: @escaping (GetAllUserResponse) -> Void, onError: @escaping (String) -> Void) {
        let path = "/users"
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
                let decodedData = try JSONDecoder().decode(GetAllUserResponse.self, from: data)
                // Assigning the data to the array
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
