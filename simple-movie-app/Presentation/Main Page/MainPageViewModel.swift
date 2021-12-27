//
//  MainViewModel.swift
//  test
//
//  Created by Behnam on 12/21/21.
//

import Foundation

protocol MainPageViewModel:MainViewModel {
    
    func getMoviesCount(section:MovieSection) -> Int
    func getMovie(section:MovieSection, index:IndexPath) -> MovieModel
    
    var loading: ((MovieSection,Bool) -> Void)? { get set }
    var observeError: ((NetworkStackError) -> Void)? { get set }
    var updateList: ((MovieSection) -> Void)? { get set }
    
}

enum MovieSection: CaseIterable {
    case popular
    case top
    case comingSoon
}

final class DefaultMainPageViewModel: MainPageViewModel {
    
    
    private let dispatchGroup = DispatchGroup()
    private var popularMovies:[MovieModel] = [] { didSet { self.updateList?(.popular) } }
    private var topMovies:[MovieModel] = [] { didSet { self.updateList?(.top) } }
    private var comingSoonMovies:[MovieModel] = [] { didSet { self.updateList?(.comingSoon) } }
    
    var loading: ((MovieSection,Bool) -> Void)?
    var observeError: ((NetworkStackError) -> Void)?
    var updateList: ((MovieSection) -> Void)?
    
    private var error:NetworkStackError? {
        didSet {
            guard let error = error else {
                return
            }
            self.observeError?(error)
        }
    }
    
    
    private let useCase:MovieUseCase

    init(useCase:MovieUseCase) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        
        loadData()
        //mockupLoading()
        
    }
    
    func mockupLoading() {
        MovieSection.allCases.forEach { i in
            self.loading?(i, true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            self.loading?(.popular, false)
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                self.loading?(.top, false)
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                self.loading?(.comingSoon, false)
            }
            self.error = .faceError(error: "limitation request for today")
        }
    }
    
    // MARK: - Private Functions
    
    private func loadData() {
        
        getPopularMovies()
        getTopMovies()
        getComingSoonMovies()
        
        dispatchGroup.notify(queue: .main) {
            print("Data Loaded")
            
        }
    }
    
    private func getPopularMovies() {
        self.loading?(.popular, true)
        dispatchGroup.enter()
        useCase.getPopularMovies { result in
            self.dispatchGroup.leave()
            self.loading?(.popular, false)
            switch result {
            case .success(let movies):
                self.popularMovies = movies.count>40 ? Array(movies[0..<40]) : movies
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    private func getTopMovies() {
        self.loading?(.top, true)
        dispatchGroup.enter()
        useCase.getTopMovies { result in
            self.dispatchGroup.leave()
            self.loading?(.top, false)
            switch result {
            case .success(let movies):
                self.topMovies = movies.count>40 ? Array(movies[0..<40]) : movies
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    private func getComingSoonMovies() {
        self.loading?(.comingSoon, true)
        dispatchGroup.enter()
        useCase.getComingSoonMovies { result in
            self.dispatchGroup.leave()
            self.loading?(.comingSoon, false)
            switch result {
            case .success(let movies):
                self.comingSoonMovies = movies.count>40 ? Array(movies[0..<40]) : movies
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    // MARK: - Protocol Functions
    
    func getMoviesCount(section:MovieSection) -> Int {
        switch section {
        case .popular: return popularMovies.count
        case .top: return topMovies.count
        case .comingSoon: return comingSoonMovies.count
        }
    }
    
    func getMovie(section:MovieSection, index:IndexPath) -> MovieModel {
        switch section {
        case .popular: return popularMovies[index.row]
        case .top: return topMovies[index.row]
        case .comingSoon: return comingSoonMovies[index.row]
        }
    }
    
}
