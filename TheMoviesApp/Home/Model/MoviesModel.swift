//
//  MoviesModel.swift
//  TheMoviesApp
//
//  Created by Juan Bonforti on 05/11/2020.

//"poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
//      "adult": false,
//      "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
//      "release_date": "2016-08-03",
//      "genre_ids": [
//        14,
//        28,
//        80
//      ],
//      "id": 297761,
//      "original_title": "Suicide Squad",
//      "original_language": "en",
//      "title": "Suicide Squad",
//      "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
//      "popularity": 48.261451,
//      "vote_count": 1466,
//      "video": false,
//      "vote_average": 5.91
//

import Foundation

struct Movies: Codable {
    let listOfMovies:[Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let popularity: Double
    let voteCount: Int
    let posterPath: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case popularity
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}



