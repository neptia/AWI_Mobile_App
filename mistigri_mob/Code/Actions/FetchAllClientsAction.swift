//
//  FetchAllClientsAction.swift
//  mistigri_mob
//
//  Created by Poomedy Rungen on 20/03/2025.
//

import SwiftUI

struct FetchAllClientsAction {
    func call(onSuccess: @escaping ([ClientResponseData]) -> Void, onError: @escaping (String) -> Void) {
        let path = "/purchases/allBuyers"
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
                let decodedData = try JSONDecoder().decode(ClientResponse.self, from: data)
                // Assigning the data to the array
                print("Successfully fetched data")
                onSuccess(decodedData.buyers)
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                onError("Fail to fetch clients. Please try again later.")
                return
            }
        }
        task.resume()
    }
}
