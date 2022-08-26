//
//  Model.swift
//  MoviesApp
//
//  Created by Virtual Machine on 09/05/22.
//

import Foundation


struct TvPopularData: Decodable {
    let results: [TvPopular]
}

struct TvPopular: Decodable {
    let posterImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case posterImage = "poster_path"
    }
    
}

struct MoviesData: Decodable {
    let results: [Movies]
}

struct Movies: Decodable {
    let name: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, overview
        case year = "first_air_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
    
}

struct GenresData: Decodable {
    let genres: [Genres]
}
struct Genres: Decodable {
    let id: Int?
    let name: String?
}
