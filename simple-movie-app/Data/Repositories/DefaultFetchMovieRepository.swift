//
//  DefaultFetchMovieRepository.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation

final class DefaultFetchMovieRepository: FetchMovieRepository {
    
    let service:WebService
    
    init(service:WebService) {
        self.service = service
    }
    
    func fetchTopMovies(completion: @escaping ResultCallback<[MovieModel]>) {
        service.request(MoviesEndpoint.topMovies) { (result: Result<MoviesResponseDTO, NetworkStackError>) in
            switch result {
            case .success(let response):
                if let items = response.items, !items.isEmpty {
                    completion(.success(items.map({ $0.toDomain() })))
                } else if let errorMsg = response.errorMessage {
                    completion(.failure(.faceError(error: errorMsg)))
                } else {
                    completion(.failure(.invalidRequest))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPopularMovies(completion: @escaping ResultCallback<[MovieModel]>) {
        service.request(MoviesEndpoint.popularMovies) { (result: Result<MoviesResponseDTO, NetworkStackError>) in
            switch result {
            case .success(let response):
                if let items = response.items, !items.isEmpty {
                    completion(.success(items.map({ $0.toDomain() })))
                } else if let errorMsg = response.errorMessage {
                    completion(.failure(.faceError(error: errorMsg)))
                } else {
                    completion(.failure(.invalidRequest))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchComingSoonMovies(completion: @escaping ResultCallback<[MovieModel]>) {
        service.request(MoviesEndpoint.comingSoon) { (result: Result<MoviesResponseDTO, NetworkStackError>) in
            switch result {
            case .success(let response):
                if let items = response.items, !items.isEmpty {
                    completion(.success(items.map({ $0.toDomain() })))
                } else if let errorMsg = response.errorMessage {
                    completion(.failure(.faceError(error: errorMsg)))
                } else {
                    completion(.failure(.invalidRequest))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
