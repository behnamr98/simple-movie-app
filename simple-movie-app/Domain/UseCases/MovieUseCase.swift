//
//  FetchMovieUseCase.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation

protocol MovieUseCase {
    
    func getTopMovies(completion: @escaping ResultCallback<[MovieModel]>)
    func getPopularMovies(completion: @escaping ResultCallback<[MovieModel]>)
    func getComingSoonMovies(completion: @escaping ResultCallback<[MovieModel]>)
    
}

final class DefaultMovieUseCase: MovieUseCase {

    
    private let repository: FetchMovieRepository
    
    init(repository: FetchMovieRepository){
        self.repository = repository
    }
    
    func getTopMovies(completion: @escaping ResultCallback<[MovieModel]>) {
        repository.fetchTopMovies { result in
            completion(result)
        }
    }
    
    func getPopularMovies(completion: @escaping ResultCallback<[MovieModel]>) {
        repository.fetchPopularMovies { result in
            completion(result)
        }
    }
    
    func getComingSoonMovies(completion: @escaping ResultCallback<[MovieModel]>) {
        repository.fetchComingSoonMovies { result in
            completion(result)
        }
    }
    
}
