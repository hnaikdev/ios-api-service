//
//  APIService.swift
//  ios-api-service
//
//  Created by Hiral Naik on 7/28/25.
//

import Foundation

public protocol APIService {
    func execute<Request: RequestConvertibleProtocol, Result: Decodable>(
        request: Request,
        result: Result.Type
    ) async throws -> Result
}

public class RequesterAPIService: APIService {
    
    let networkService: RequesterServiceProtocol
    
    public init(networkService: RequesterServiceProtocol) {
        self.networkService = networkService
    }
    
    public func execute<Request, Result>(request: Request, result: Result.Type) async throws -> Result where Request : RequestConvertibleProtocol, Result : Decodable {
        do {
            let data: Data = try await networkService.send(request: request)
            let result = try JSONDecoder().decode(Result.self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
