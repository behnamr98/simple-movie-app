//
//  FetchMovieRepository.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation


protocol FetchMovieRepository {
    
    func fetchTopMovies(completion: @escaping ResultCallback<[MovieModel]>)
    func fetchPopularMovies(completion: @escaping ResultCallback<[MovieModel]>)
    func fetchComingSoonMovies(completion: @escaping ResultCallback<[MovieModel]>)
    
}
