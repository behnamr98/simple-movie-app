//
//  Endpoint.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation

public enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

protocol Endpoint {
    var request: URLRequest? { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: [String : String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var scheme: String { get }
    var host: String { get }
}

extension Endpoint {
    func request(forEndpoint endpoint: String) -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endpoint
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let httpHeaders = httpHeaders {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
