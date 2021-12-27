//
//  MovieDBUseCase.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation

protocol MovieDBUseCase {
    
    func saveInBookmark(_ model:MovieModel)
    
    func removeFromBookmark(_ id:String)
    
    func fetchAllBookmarked() -> [Movie]
    
    func isBookmarked(_ model:MovieModel) -> Bool
}

final class DefaultMovieDBUseCase: MovieDBUseCase {
    
    
    private let repository:MoviesDBRepository
    
    init(repository:MoviesDBRepository) {
        self.repository = repository
    }
    
    func saveInBookmark(_ model: MovieModel) {
        repository.bookmarkMovie(model: model)
    }
    
    func removeFromBookmark(_ id:String) {
        repository.deleteFromBookmark(id: id)
    }
    
    func fetchAllBookmarked() -> [Movie] {
        repository.fetchBookmarkMovies()
    }
    
    func isBookmarked(_ model: MovieModel) -> Bool {
        repository.isBookmarked(id: model.id)
    }
    
}
