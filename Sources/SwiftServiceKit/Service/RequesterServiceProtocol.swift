//
//  RequesterServiceProtocol.swift
//  ios-api-service
//
//  Created by Hiral Naik on 7/25/25.
//

import Foundation

public protocol RequesterServiceProtocol {
    func send<Request: RequestConvertibleProtocol>(
        request: Request
    ) async throws -> Data
    
    func send<Request: RequestConvertibleProtocol, Input, Output>(
        request: Request,
        jsonDeserializer: @escaping (Input) -> Output?
    ) async throws -> Output
    
    func send<Request: RequestConvertibleProtocol, Input, Output>(
        request: Request,
        responseDeserializer: @escaping (Input) -> Output?
    ) async throws -> Output
    
    func send<Request: RequestConvertibleProtocol>(
        request: Request) async throws
}
