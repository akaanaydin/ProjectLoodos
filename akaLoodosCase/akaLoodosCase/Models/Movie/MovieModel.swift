//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//


// MARK: - Result
struct Result: Codable {
    let search: [Search]?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, type, poster, imdbID: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        case imdbID
    }
}
