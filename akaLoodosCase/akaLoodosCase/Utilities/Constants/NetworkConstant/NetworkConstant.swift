//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

extension Constant {
// MARK: - Network Constant
    class NetworkConstant{
        enum SearchMovieServiceEndPoint: String {
            case BASE_URL = "https://www.omdbapi.com"
            case API_KEY = "apikey=YOUR_API_KEY"
            
            static func searchMovie(searchMovieName: String) -> String {
                "\(BASE_URL.rawValue)?s=\(searchMovieName)&\(API_KEY.rawValue)"
            }
            
            static func detailMovie(movieImdbId: String) -> String {
                "\(BASE_URL.rawValue)?i=\(movieImdbId)&\(API_KEY.rawValue)"
            }
        }
    }
}

