//
//  RequestConvertibleProtocol.swift
//  ios-api-service
//
//  Created by Hiral Naik on 7/25/25.
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod

public protocol RequestConvertibleProtocol {
    func asURLRequest() throws -> URLRequest
}

public protocol RequestBuilder {
    func build(method: HTTPMethod, baseURL: URL?, path: String?, params: [String: Any]?, paramsList: [Any]?, body: Data?, headers: [String: String]?, forceURLEncoding: Bool) throws -> URLRequest
    
    func build(parameters: [String: Sendable]?) -> [String: Sendable]?
}

extension RequestBuilder {
    public func build(
        method: HTTPMethod = .get,
        baseURL: URL? = nil,
        path: String? = nil,
        params: [String: Sendable]? = nil,
        paramsList: [Any]? = nil,
        body: Data? = nil,
        headers: [String: String]? = nil,
        forceURLEncoding: Bool = false
    ) throws -> URLRequest {
        
        let parameters = build(parameters: params)
        
        let allHeaders = [
            "Accept": "application/json"
        ]
        
        var url = baseURL ?? URL(string: "")!
        
        if let path = path {
            url = url.appendingPathComponent(path)
        }
        
        var request = try URLRequest(url: url, method: method, headers: HTTPHeaders(allHeaders))
        if body != nil {
            request.httpBody = body
        } else if let paramsList = paramsList {
            request = try encode(request, with: paramsList)
        } else {
            if method == .get || forceURLEncoding {
                request = try URLEncoding.default.encode(request, with: parameters)
            } else {
                request = try JSONEncoding.default.encode(request, with: parameters)
            }
        }
        
        return request
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: [Any]) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        return urlRequest
    }
}
