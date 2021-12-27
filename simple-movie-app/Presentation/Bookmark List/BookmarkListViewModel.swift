//
//  BookmarkListViewModel.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation

protocol BookmarkListViewModel: MainViewModel {
    
    func getBookmarksCount() -> Int
    func getBookmark(_ index:IndexPath) -> Movie
    
    var updateList: (() -> Void)? { get set }
}


final class DefaultBookmarkListViewModel: BookmarkListViewModel {
    
    var updateList: (() -> Void)?
    
    private var movies = [Movie]() {
        didSet { updateList?() }
    }
    private let useCase:MovieDBUseCase
    
    init(useCase:MovieDBUseCase) {
        self.useCase = useCase
    }
    
    func viewWillAppear() {
        movies = useCase.fetchAllBookmarked()
    }
    
    // MARK: - Protocol Functions
    
    func getBookmarksCount() -> Int {
        movies.count
    }
    
    func getBookmark(_ index:IndexPath) -> Movie {
        movies[index.row]
    }
    
}
