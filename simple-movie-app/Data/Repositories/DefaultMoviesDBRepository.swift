//
//  DefaultMoviesDBRepository.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation

final class DefaultMoviesDBRepository: MoviesDBRepository {
    
    
    
    private let tableHelper = MovieTableHelper()
    
    init() {}
    
    func fetchBookmarkMovies() -> [Movie] {
        return tableHelper.getAllBookmarks()
    }
    
    func bookmarkMovie(model: MovieModel) {
        tableHelper.addMovie(model)
    }
    
    func deleteFromBookmark(id:String) {
        tableHelper.deleteMovie(id: id)
    }
    
    func isBookmarked(id:String) -> Bool {
        return tableHelper.isBookmarked(id: id)
    }
    
}
