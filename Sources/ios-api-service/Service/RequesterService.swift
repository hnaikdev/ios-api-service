//
//  RequesterService.swift
//  ios-api-service
//
//  Created by Hiral Naik on 7/25/25.
//

import Foundation
import Alamofire

public class RequesterService: RequesterServiceProtocol {
    
    public init() { }
    
    public func send<Request>(request: Request) async throws -> Data where Request : RequestConvertibleProtocol {
        do {
            let urlRequest = try request.asURLRequest()
            let data: Data = try await dispatch(request: urlRequest)
            return data
        } catch {
            throw error
        }
    }
    
    public func send<Request, Input, Output>(request: Request, jsonDeserializer: @escaping (Input) -> Output?) async throws -> Output where Request : RequestConvertibleProtocol {
        do {
            let urlRequest = try request.asURLRequest()
            let response = try await dispatch(request: urlRequest, jsonDeserializer: jsonDeserializer)
            return response
        } catch {
            throw error
        }
        
    }
    
    public func send<Request, Input, Output>(request: Request, responseDeserializer: @escaping (Input) -> Output?) async throws -> Output where Request : RequestConvertibleProtocol {
        do {
            let urlRequest = try request.asURLRequest()
            let response = try await dispatch(request: urlRequest, responseDeserializer: responseDeserializer)
            return response
        } catch {
            throw error
        }
    }
    
    public func send<Request>(request: Request) async throws where Request : RequestConvertibleProtocol {
        do {
            let urlRequest = try request.asURLRequest()
            try await dispatch1(request: urlRequest)
        } catch {
            throw error
        }
    }
    
    private func dispatch(request: URLRequest) async throws -> Data {
        let response = await AF.request(request, interceptor: .retryPolicy)
            .cacheResponse(using: .cache)
            .redirect(using: .follow)
            .serializingData()
            .response
        
        switch response.result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    private func dispatch<Input, Output>(request: URLRequest, jsonDeserializer: @escaping (Input) -> Output?) async throws -> Output {
        let response = await AF.request(request, interceptor: .retryPolicy)
            .cacheResponse(using: .cache)
            .redirect(using: .follow)
            .serializingData()
            .response
        
        switch response.result {
        case .success(let data):
            guard let myData = data as? Input, let output = jsonDeserializer(myData) else {
                throw NSError(domain: "com.example.RequesterService", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Failed to deserialize JSON"])
            }
            return output
        case .failure(let error):
            throw error
        }
    }
    
    private func dispatch<Input, Output>(request: URLRequest, responseDeserializer: @escaping (Input) -> Output?) async throws -> Output {
        let response = await AF.request(request, interceptor: .retryPolicy)
            .cacheResponse(using: .cache)
            .redirect(using: .follow)
            .serializingData()
            .response
        
        guard let myResponse = response.response?.allHeaderFields as? Input, let output = responseDeserializer(myResponse) else {
            throw NSError(domain: "com.example.RequesterService", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Failed to deserialize response"])
        }
        
        return output
    }
    
    private func dispatch1(request: URLRequest) async throws {
        let response = await AF.request(request, interceptor: .retryPolicy)
            .cacheResponse(using: .cache)
            .redirect(using: .follow)
            .serializingData()
            .response
        
        if let error = response.error {
            throw error
        }
    }
}
