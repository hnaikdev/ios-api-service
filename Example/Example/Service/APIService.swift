//
//  APIService.swift
//  Example
//
//  Created by Hiral Naik on 7/28/25.
//

import Foundation
import SwiftServiceKit

protocol APIServiceProtocol {
    func fetchData() async throws -> [User]
}

class APIService: APIServiceProtocol {
    
    let apiService: SwiftServiceKit.APIService
    
    init(apiService: SwiftServiceKit.APIService) {
        self.apiService = apiService
    }
    
    func fetchData() async throws -> [User] {
        do {
            let request = Requests.V1.getUsers
            return try await apiService.execute(request: request, result: [User].self)
        } catch {
            throw error
        }
    }
}
