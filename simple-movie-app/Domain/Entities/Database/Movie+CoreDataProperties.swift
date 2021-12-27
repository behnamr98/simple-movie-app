//
//  Movie+CoreDataProperties.swift
//  test
//
//  Created by Behnam on 12/22/21.
//  Copyright © 2021 Part DP. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var year: Int32
    @NSManaged public var id: String?
    @NSManaged public var rank: Int32
    @NSManaged public var fullTitle: String?
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var director: String?
    @NSManaged public var imdbRating: Double
    @NSManaged public var imdbRatingCount: Int64

}

extension Movie : Identifiable {

    class func instance(with id: String, in context:NSManagedObjectContext) -> Movie? {
        let request = NSFetchRequest<Movie>(entityName: "Movie")
        
        // create an NSPredicate to get the instance you want to make change
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        do {
            let alerts = try context.fetch(request)
            return alerts.first(where: {$0.id == id})
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
