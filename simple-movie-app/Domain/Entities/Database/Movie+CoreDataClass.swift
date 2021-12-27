//
//  Movie+CoreDataClass.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {

    class func buider(into: NSManagedObjectContext) -> Movie {
        return NSEntityDescription.insertNewObject(forEntityName: "Movie", into: into) as! Movie
    }
    
    func toDomain() -> MovieModel {
        return MovieModel(
            id: self.id ?? "",
            rank: Int(self.rank),
            title: self.title ?? "",
            fullTitle: self.fullTitle ?? "",
            year: Int(self.year),
            image: self.image ?? "",
            director: self.director ?? "",
            imDbRating: self.imdbRating,
            imDbRatingCount: Int(self.imdbRatingCount)
        )
        
        
    }
}
