//
//  MovieTableHelper.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//

import Foundation
import CoreData

final class MovieTableHelper: MainTableHelper {
    
    private let tableName = "Movie"
    
    
    func addMovie(_ model:MovieModel) {
        let contextWorker = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        contextWorker.parent = mainContextInstance
        let movie = Movie.buider(into: contextWorker)
        
        movie.year = Int32(model.year)
        movie.id = model.id
        movie.rank = Int32(model.rank)
        movie.fullTitle = model.fullTitle
        movie.title = model.title
        movie.image = model.image
        movie.director = model.director
        movie.imdbRating = model.imDbRating
        movie.imdbRatingCount = Int64(model.imDbRatingCount)
        
        persistenceManager.saveWorkerContext(contextWorker)
        persistenceManager.mergeWithMainContext()
    }
    
    func deleteMovie(id:String) {
        guard let movie = Movie.instance(with: id, in: mainContextInstance) else {return}
        
        mainContextInstance.delete(movie)
        persistenceManager.mergeWithMainContext()
    }
    
    func getAllBookmarks() -> [Movie] {
        let request = NSFetchRequest<Movie>(entityName: tableName)
        
        do {
            let movies = try mainContextInstance.fetch(request)
            return movies
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func isBookmarked(id: String) -> Bool {
        guard let _ = Movie.instance(with: id, in: mainContextInstance) else {
            return false
        }
        return true
    }
    
    // MARK: - Private Functions
    
}
