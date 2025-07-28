//
//  Requests.swift
//  Example
//
//  Created by Hiral Naik on 7/28/25.
//

import ios_api_service
import Foundation

enum Requests {
    enum V1 {
        case getUsers
    }
}

extension Requests.V1: RequestConvertibleProtocol, RequestBuilder {
    func asURLRequest() throws -> URLRequest {
        var request: URLRequest
        
        switch self {
        case .getUsers:
            let url = URL(string: "https://fake-json-api.mock.beeceptor.com")
            request = try build(baseURL: url, path: "/users", forceURLEncoding: true)
        }
        
        return request
    }
}
