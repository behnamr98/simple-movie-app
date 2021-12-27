//
//  MoviesResponseDTO + Mapping.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation


struct MoviesResponseDTO:Codable {
    
    
    let items:[MovieDTO]?
    let errorMessage:String?
    
}


struct MovieDTO:Codable {
    
    let id:String?
    let rank:String?
    let rankUpDown:String?
    let title:String?
    let fullTitle:String?
    let year:String?
    let image:String?
    let crew:String?
    let imDbRating:String?
    let imDbRatingCount:String?
}

extension MovieDTO {
    
    func toDomain() -> MovieModel {
        return MovieModel(
            id: self.id ?? "",
            rank: Int(self.rank ?? "0")!,
            title: self.title ?? "",
            fullTitle: self.fullTitle ?? "",
            year: Int(self.year ?? "0")!,
            image: self.image ?? "",
            director: self.crew ?? "",
            imDbRating: Double(self.imDbRating ?? "1") ?? 1,
            imDbRatingCount: Int(self.imDbRatingCount ?? "0") ?? 0
        )
        
    }
    
}
