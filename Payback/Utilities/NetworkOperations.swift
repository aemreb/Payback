//
//  NetworkOperations.swift
//  Payback
//
//  Created by Emre Boyaci on 5.12.2022.
//

import Foundation

class NetworkOperations {
    static private func apiCall(_ url: String) async throws -> Data? {
        guard let url = URL(string: url) else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (200 ... 299) ~= (response as? HTTPURLResponse)?.statusCode ?? 404 else { fatalError("Error while fetching data") }
        
        return data
    }
    
    static func getTransactions() async -> Data? {
        do {
            return try await NetworkOperations.apiCall(APIConstants.apiURL)
        } catch {
            print(error)
        }
        return nil
    }
}
