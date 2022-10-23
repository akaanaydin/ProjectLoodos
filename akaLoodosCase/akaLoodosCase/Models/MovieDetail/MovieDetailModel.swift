//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

// MARK: - MovieDetailModel
struct MovieDetailModel: Codable {
    let title, year, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot: String?
    let awards: String?
    let poster: String?
    let type: String?
    let imdbRating: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case type = "Type"
        case imdbRating
    
    }
}
