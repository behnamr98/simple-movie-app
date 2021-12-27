//
//  MoviesDBRepository.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation

protocol MoviesDBRepository {
    
    func fetchBookmarkMovies() -> [Movie]
    func bookmarkMovie(model: MovieModel)
    func deleteFromBookmark(id:String)
    func isBookmarked(id:String) -> Bool
    
}
