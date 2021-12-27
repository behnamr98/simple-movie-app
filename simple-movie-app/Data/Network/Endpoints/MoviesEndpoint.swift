//
//  APIService.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "imdb-api.com"
    }
}

enum MoviesEndpoint {
    
    case comingSoon
    case popularMovies
    case topMovies
    
}

extension MoviesEndpoint: Endpoint {
    
    var request: URLRequest? {
        switch self {
        case .topMovies:
            return request(forEndpoint: "/en/API/Top250Movies/k_fcfyn4uu")
        case .popularMovies:
            return request(forEndpoint: "/en/API/MostPopularMovies/k_fcfyn4uu")
        case .comingSoon:
            return request(forEndpoint: "/en/API/ComingSoon/k_fcfyn4uu")
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var httpHeaders: [String : String]? {
        return [:]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
}
