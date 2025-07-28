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
            let request = Requests.V1.getUsers
            return try await execute(request: request, type: [User].self)
        } catch {
            throw error
        }
    }
    
    private func execute<Request: RequestConvertibleProtocol, Result: Codable>(request: Request, type: Result.Type) async throws -> Result {
        do {
            let data: Data = try await networkService.send(request: request)
            let decoder: JSONDecoder = JSONDecoder()
            let result: Result = try decoder.decode(Result.self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
