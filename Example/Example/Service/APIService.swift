//
//  APIService.swift
//  Example
//
//  Created by Hiral Naik on 7/28/25.
//

import Foundation
import ios_api_service

protocol APIServiceProtocol {
    func fetchData() async throws -> [User]
}

class APIService: APIServiceProtocol {
    
    let networkService: RequesterServiceProtocol
    
    init(networkService: RequesterServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchData() async throws -> [User] {
        do {
            let urlString = "https://fake-json-api.mock.beeceptor.com/users"
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            
            let result = try await networkService.send(request: <#T##RequestConvertibleProtocol#>)
            
            for user in result {
                try await cacheService.store(user)
            }
            
            return result
        } catch {
            throw error
        }
    }
}
