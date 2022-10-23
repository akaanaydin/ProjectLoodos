//
//  AppDelegate.swift
//  akaLoodosCase
//
//  Created by Kaan AYDIN on 20.10.2022.
//

import Alamofire

//MARK: - Services Protocol
protocol ServiceProtocol {
    // Movie Functions
    func searchMovie(searchMovieName: String, onSuccess: @escaping (Result?) -> Void, onError: @escaping (AFError) -> Void)
    func getMovieDetail(movieImdbId: String, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void)
}


//MARK: - Services
final class Services: ServiceProtocol {
    // Search Movies
    func searchMovie(searchMovieName: String, onSuccess: @escaping (Result?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.SearchMovieServiceEndPoint.searchMovie(searchMovieName: searchMovieName)) { (response: Result) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    // Get Movie Detail
    func getMovieDetail(movieImdbId: String, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.SearchMovieServiceEndPoint.detailMovie(movieImdbId: movieImdbId)) { (response: MovieDetailModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
