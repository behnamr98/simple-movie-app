//
//  DetailsMovieViewModel.swift
//  test
//
//  Created by Behnam on 12/21/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation

protocol DetailsMovieViewModel:MainViewModel {
    
    var isBookmark:Bool { get }
    
    func bookmarkTapped()
    var observeBookmarkState: ((Bool) -> Void)? { get set }
}


final class DefaultDetailsMovieViewModel: DetailsMovieViewModel {
    
    
    var isBookmark: Bool = false { didSet { observeBookmarkState?(isBookmark) } }
    var observeBookmarkState: ((Bool) -> Void)?
    
    
    private let movie:MovieModel
    private let useCase:MovieDBUseCase
    
    init(movie:MovieModel, useCase:MovieDBUseCase){
        self.movie = movie
        self.useCase = useCase
    }
    
    
    func viewDidLoad() {
        isBookmark = useCase.isBookmarked(movie)
    }
    
    // MARK: - Protocol Functions
    
    func bookmarkTapped() {
        if isBookmark {
            useCase.removeFromBookmark(movie.id)
        } else {
            useCase.saveInBookmark(movie)
        }
        isBookmark = !isBookmark
    }
    
    
    
}
