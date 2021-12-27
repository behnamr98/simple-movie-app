//
//  WebService.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation

protocol WebService {
    func request<T: Decodable>(_ endpoint: Endpoint, completition: @escaping ResultCallback<T>)
}

class DefaultWebService: WebService {
    private let urlSession: URLSession
    private let parser: Parser
    private let networkActivity: NetworkActivityProtocol
    
    init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default),
         parser: Parser = Parser(),
         networkActivity: NetworkActivityProtocol = NetworkActivity()) {
        self.urlSession = urlSession
        self.parser = parser
        self.networkActivity = networkActivity
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, completition: @escaping ResultCallback<T>) {
        
        guard let request = endpoint.request else {
            OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.invalidRequest)) })
            return
        }
        
        networkActivity.increment()
        
        let task = urlSession.dataTask(with: request) { [unowned self] (data, response, error) in
            
            self.networkActivity.decrement()
            
            if let error = error {
                OperationQueue.main.addOperation({ completition(.failure(.responseError(error: error))) })
                return
            }
            
            guard let data = data else {
                OperationQueue.main.addOperation({ completition(.failure(NetworkStackError.dataMissing)) })
                return
            }
            
            self.parser.json(data: data, completition: completition)
        }
        
        task.resume()
    }
}

// Parser

protocol ParserProtocol {
    func json<T: Decodable>(data: Data, completition: @escaping ResultCallback<T>)
}

struct Parser {
    let jsonDecoder = JSONDecoder()
    
    func json<T: Decodable>(data: Data, completition: @escaping ResultCallback<T>) {
        do {
            let result: T = try jsonDecoder.decode(T.self, from: data)
            OperationQueue.main.addOperation { completition(.success(result)) }
            
        } catch let error {
            OperationQueue.main.addOperation { completition(.failure(.parserError(error: error))) }
        }
    }
}
